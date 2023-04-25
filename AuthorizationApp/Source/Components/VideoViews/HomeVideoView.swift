import Foundation
import Rswift
import UIKit
import AVKit
import AVFoundation

class HomeVideoView: UIView {
    private var player = AVPlayer()
    private var videoPlayerView = VideoPlayerView()
    private var isVideoPlaying = VideoState.paused
    private var previewImageView = UIImageView()
    private var stackView = UIStackView()
    private var controlStackView = UIStackView()
    private var playPauseButton = UIButton()
    private var fullScreenButton = UIButton()
    private var videoControlSlider = UISlider()
    private var timeCodeLabel = UILabel()
    private var notification = NotificationCenter.default
    var url: URL
    
    init(url: URL) {
        self.url = url
        
        super.init(frame: .zero)
        setup()
        generate()
        trackPlayerProgress()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        addSubview(videoPlayerView)
        videoPlayerView.frame = self.frame
        configStackViewContrainsts()
        configPlayPauseButtonConstraints()
        configSliderConstraints()
        configControlStackViewConstraints()
    }
}

// MARK: - Setup

extension HomeVideoView {
    func setup() {
        setupVideoPlayer()
        setupStackView()
        setupControlStckView()
        setupButtons()
        setupSlider()
        setupLabel()
    }
}

// MARK: - VideoPlayerView

extension HomeVideoView {
    
    private func setupVideoPlayer() {
        guard let videoURL = URL(string: "https://firebasestorage.googleapis.com:443/v0/b/auth-91b43.appspot.com/o/videos%2Fcountries%2FUkraine.mp4?alt=media&token=1bd8fa7a-69b4-4619-b34d-cb2395874c16") else { return }
        player = AVPlayer(url: videoURL)
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        player.isMuted = true
        videoPlayerView.player = player
        addObserver()
    }
    
    func play() {
        player.play()
        isVideoPlaying = .playing
    }
    
    func pause() {
        player.pause()
    }
    
    func trackPlayerProgress() {
        let inreval = CMTime(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: inreval, queue: DispatchQueue.main, using: { progresTime in
            let seconds = CMTimeGetSeconds(progresTime)
            let secondsString = String(format: "%02d", Int(seconds) % 60)
            let minutesString = String(format: "%02d", Int(seconds / 60))
            
            self.timeCodeLabel.text = "\(minutesString):\(secondsString)"
            
            if let duration = self.player.currentItem?.duration {
                let durationSeconds = CMTimeGetSeconds(duration)
                self.videoControlSlider.value = Float(seconds / durationSeconds)
            }
        })
    }
    
    func addObserver() {
        notification.addObserver(self, selector: #selector(videoDidEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
}

// MARK: - Objc

private extension HomeVideoView {
    
    @objc func videoDidEnded() {
        pause()
        isVideoPlaying = .reloading
        playPauseButton.setImage(R.image.reload(), for: .normal)
    }
    
    @objc func playVideo() {
        switch isVideoPlaying {
        case .paused:
            playPauseButton.setImage(R.image.pause(), for: .normal)
            play()
            isVideoPlaying = .playing
        case .playing:
            playPauseButton.setImage(R.image.play(), for: .normal)
            pause()
            isVideoPlaying = .paused
        case .reloading:
            player.seek(to: .zero)
            play()
            isVideoPlaying = .playing
            playPauseButton.setImage(R.image.pause(), for: .normal)
        }
    }
    
    @objc func handelSliderChange() {
        if let duration = player.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoControlSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player.seek(to: seekTime)
        }
    }
}

// MARK: - PreviewImage

private extension HomeVideoView {
    
    func generate() {
        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        let timestamp = CMTime(seconds: 10, preferredTimescale: 60)
        
        if let imageRef = try? imageGenerator.copyCGImage(at: timestamp, actualTime: nil) {
            let image = UIImage(cgImage: imageRef)
            self.previewImageView = UIImageView(image: image)
        }
    }
    
    func openFullScreenVideo(controller: AVPlayerViewController) {
        controller.player = player
    }
}

// MARK: - UIStackView

extension HomeVideoView {
    
    func setupStackView() {
        videoPlayerView.addSubview(stackView)
        stackView.addArrangedSubview(playPauseButton)
        stackView.addArrangedSubview(controlStackView)
        stackView.addArrangedSubview(fullScreenButton)
        stackView.axis = .horizontal
    }
    
    func setupControlStckView() {
        controlStackView.addArrangedSubview(timeCodeLabel)
        controlStackView.addArrangedSubview(videoControlSlider)
        controlStackView.axis = .vertical
    }
    
    func configStackViewContrainsts() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: videoPlayerView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: -5),
            stackView.centerXAnchor.constraint(equalTo: videoPlayerView.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configControlStackViewConstraints() {
        controlStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            controlStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - UIButton

extension HomeVideoView {
    
    func setupButtons() {
        playPauseButton.setImage(R.image.play(), for: .normal)
        fullScreenButton.setImage(R.image.fullScreen(), for: .normal)
        playPauseButton.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
    }
    
    func configPlayPauseButtonConstraints() {
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playPauseButton.heightAnchor.constraint(equalToConstant: 50),
            playPauseButton.widthAnchor.constraint(equalToConstant: 50),
            fullScreenButton.heightAnchor.constraint(equalToConstant: 50),
            fullScreenButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - UISlider

extension HomeVideoView {
    
    func setupSlider() {
        videoControlSlider.thumbTintColor = .red
        videoControlSlider.minimumTrackTintColor = .red
        videoControlSlider.maximumTrackTintColor = .darkGray
        videoControlSlider.addTarget(self, action: #selector(handelSliderChange), for: .valueChanged)
    }
    
    func configSliderConstraints() {
        videoControlSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
        ])
    }
}

// MARK: - UILabel

extension HomeVideoView {
    func setupLabel() {
        timeCodeLabel.textColor = .white
    }
}

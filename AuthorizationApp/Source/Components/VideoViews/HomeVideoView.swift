import Foundation
import Rswift
import UIKit
import AVFoundation
import AVKit

class HomeVideoView: UIView {
    private var player = AVPlayer()
    private var videoPlayerView = VideoPlayerView()
    private var isVideoPlaying = VideoState.pause
    private var previewImageView = UIImageView()
    private var stackView = UIStackView()
    private var controlStackView = UIStackView()
    private var playPauseButton = UIButton()
    private var fullScreenButton = UIButton()
    private var videoControlSlider = UISlider()
    private var timeCodeLabel = UILabel()
    
    private var notification = NotificationCenter.default
    var paybackObserver: Any?
    var fullScreenCompletion: ((AVPlayer) -> Void)?
    var url: URL?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(videoPlayerView)
        videoPlayerView.frame = self.frame
        videoPlayerView.playerLayer.videoGravity = .resizeAspect
        configStackViewContrainsts()
        configPlayPauseButtonConstraints()
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
    
    func update() {
        setupVideoPlayer()
        addVideoTimeObserver()
    }
}

// MARK: - VideoPlayerView

extension HomeVideoView {
    
    private func setupVideoPlayer() {
        if let url = url  {
            let asset = AVAsset(url: url)
            let item = AVPlayerItem(asset: asset)
            player = AVPlayer(playerItem: item)
            didFinishVideoObserver(palyerItem: item)
        }
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        player.isMuted = true
        videoPlayerView.player = player
    }
    
    func play() {
        player.play()
        isVideoPlaying = .play
    }
    
    func pause() {
        player.pause()
    }
    
    private func addVideoTimeObserver() {
        let inreval = CMTime(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: inreval, queue: DispatchQueue.main, using: { [weak self] progresTime in
            let seconds = CMTimeGetSeconds(progresTime)
            let secondsString = String(format: "%02d", Int(seconds) % 60)
            let minutesString = String(format: "%02d", Int(seconds / 60))
            
            self?.timeCodeLabel.text = "\(minutesString):\(secondsString)"
            
            if let duration = self?.player.currentItem?.duration {
                let durationSeconds = CMTimeGetSeconds(duration)
                self?.videoControlSlider.value = Float(seconds / durationSeconds)
            }
        })
    }
    
    func didFinishVideoObserver(palyerItem: AVPlayerItem) {
        paybackObserver = notification.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: palyerItem,
            queue: .main)
        { [weak self] _ in
            self?.pause()
            self?.isVideoPlaying = .reload
            self?.playPauseButton.setImage(R.image.reload(), for: .normal)
        }
    }
    
    func setupPlayerLayer() {
        videoPlayerView.player = player
        videoPlayerView.playerLayer.frame = self.bounds
        videoPlayerView.playerLayer.videoGravity = .resizeAspect
        videoPlayerView.playerLayer.contentsGravity = .resizeAspect
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
        playPauseButton.addTarget(
            self,
            action: #selector(playVideo),
            for: .touchUpInside)
        
        fullScreenButton.addTarget(
            self,
            action: #selector(fullScreenButtonPressed),
            for: .touchUpInside)
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
        videoControlSlider.addTarget(
            self,
            action: #selector(handelSliderChange),
            for: .valueChanged)
    }
}

// MARK: - UILabel

extension HomeVideoView {
    func setupLabel() {
        timeCodeLabel.textColor = .white
    }
}

// MARK: - Objc

private extension HomeVideoView {
    
    @objc func playVideo() {
        switch isVideoPlaying {
        case .pause:
            playPauseButton.setImage(R.image.pause(), for: .normal)
            play()
            isVideoPlaying = .play
        case .play:
            playPauseButton.setImage(R.image.play(), for: .normal)
            pause()
            isVideoPlaying = .pause
        case .reload:
            player.seek(to: .zero)
            play()
            isVideoPlaying = .play
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
    
    @objc func fullScreenButtonPressed() {
        NotificationCenter.default.addObserver(self, selector: #selector(avPlayerDidDismiss), name: Notification.Name("avPlayerDidDismiss"), object: nil)
        fullScreenCompletion?(player)
    }
    
    @objc func avPlayerDidDismiss(_ notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {[weak self] in
            self?.playVideo()
            NotificationCenter.default.removeObserver(self as Any, name: Notification.Name("avPlayerDidDismiss"), object: nil)
        }
    }
}


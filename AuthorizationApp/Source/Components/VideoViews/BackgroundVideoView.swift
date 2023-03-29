import Foundation
import UIKit
import AVFoundation

class BackgroundVideoView: UIView {
    
    private let videoPlayerView = VideoPlayerView()
    private var player = AVPlayer()
    var video: String
    var type: VideoType
    
    init(video: String, type: VideoType) {
        self.video = video
        self.type = type
        
        super.init(frame: .zero)
        
        setupVideoPlayer()
        setupPlayerLayer()
        playVideo()
    }
    
    override func layoutSubviews() {
        addSubview(videoPlayerView)
        videoPlayerView.frame = self.frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - VideoPlayerView

extension BackgroundVideoView {
    
    private func setupVideoPlayer() {
        guard let path = Bundle.main.path(forResource: video, ofType: type.stringValue) else { return }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        player.isMuted = true
        videoPlayerView.player = player
    }
    
    private func playVideo() {
        NotificationCenter.default.addObserver(self, selector: #selector(playerSeek), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: videoPlayerView.player?.currentItem)
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    @objc private func playerSeek() {
        player.seek(to: CMTime.zero)
    }
}

// MARK: - PlayerLayer

extension BackgroundVideoView {
    
    private func setupPlayerLayer() {
        videoPlayerView.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    }
}

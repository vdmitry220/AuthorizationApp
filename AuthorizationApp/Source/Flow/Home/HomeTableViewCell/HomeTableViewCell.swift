import UIKit
import AVKit

class HomeTableViewCell: UITableViewCell {
    
    private var homeVideoView = HomeVideoView()
    private var titleLable = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setLabel()
        setVideoView()
        homeVideoView.update()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}

// MARK: - ReuseIdentifier

extension HomeTableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

// MARK: - HomeTableViewCell

extension HomeTableViewCell {
    
    func setVideoView() {
        contentView.addSubview(homeVideoView)
        configHomeVideoViewConstraints()
    }

    func configHomeVideoViewConstraints() {
        homeVideoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeVideoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            homeVideoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            homeVideoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            homeVideoView.bottomAnchor.constraint(equalTo: titleLable.topAnchor)
        ])
    }
    
    func update(video: Video) {
        homeVideoView.url = video.url
        titleLable.text = video.title
    }
}

// MARK: - UILabel

extension HomeTableViewCell {
    
    func setLabel() {
        contentView.addSubview(titleLable)
        configTitleLabelConstraints()
    }

    func configTitleLabelConstraints() {
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - VideoPlayer

extension HomeTableViewCell {
    
    func fullScreen(_ completion: @escaping (AVPlayer) -> Void) {
        homeVideoView.fullScreenCompletion = completion
    }
    
    func playerControllerWasDismissed() {
        homeVideoView.setupPlayerLayer()
    }
}



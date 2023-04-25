import UIKit

class HomeTableViewCell: UITableViewCell {
    
    private var homeVideoView = HomeVideoView(url: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/auth-91b43.appspot.com/o/videos%2Fcountries%2FUkraine.mp4?alt=media&token=1bd8fa7a-69b4-4619-b34d-cb2395874c16")!)
    private var titleLable = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setLabel()
        setVideoView()
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
        configHomeVideoViewContraints()
    }

    func configHomeVideoViewContraints() {
        homeVideoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeVideoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            homeVideoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            homeVideoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            homeVideoView.bottomAnchor.constraint(equalTo: titleLable.topAnchor)
        ])
    }
}

// MARK: - UILabel

extension HomeTableViewCell {
    
    func setLabel() {
        contentView.addSubview(titleLable)
        titleLable.text = "Test"
        configTitleLableConstraints()
    }

    func configTitleLableConstraints() {
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}



import UIKit
import Rswift

class ProfileViewController: UIViewController {
    
    private var viewModel: ProfileViewModel!
    
    private var infoUserStackView = UIStackView()
    private var avatarImageView = UIImageView(image: R.image.avatar())
    private var usernameLabel = UILabel()
    private var editProfileButton = CustomButton(title: "Edit profile", color: .clear, borderColor: .black)
    private var logOutButton = CustomButton(title: "Log out", color: .clear, borderColor: .black)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemCyan
        
        configureStackView()
        setupImage()
        setupButton()
        setupLabel()
    }
    
    func inject(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Buttons

extension ProfileViewController {
    
    func setupButton() {
        self.view.addSubview(logOutButton)
        logOutButton.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)
        setLogOutButtonConstraints()
        setEditProfileButtonConstraints()
    }
    
    func setLogOutButtonConstraints() {
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    func setEditProfileButtonConstraints() {
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.leadingAnchor.constraint(equalTo: infoUserStackView.leadingAnchor, constant: 1).isActive = true
        editProfileButton.trailingAnchor.constraint(equalTo: infoUserStackView.trailingAnchor, constant: -1).isActive = true
    }
    
    @objc func logOutButtonPressed() {
        viewModel.logOut()
    }
}

// MARK: - StackView

extension ProfileViewController {
    func configureStackView() {
        view.addSubview(infoUserStackView)
        
        infoUserStackView.axis = .vertical
        infoUserStackView.alignment = .center
        infoUserStackView.distribution = .fill
        infoUserStackView.spacing = 10.0
        infoUserStackView.addArrangedSubview(avatarImageView)
        infoUserStackView.addArrangedSubview(usernameLabel)
        infoUserStackView.addArrangedSubview(editProfileButton)
        
        setStackViewConstraints()
    }
    
    func setStackViewConstraints() {
        infoUserStackView.translatesAutoresizingMaskIntoConstraints = false
        infoUserStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        infoUserStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        infoUserStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
}

// MARK: - ImageView

extension ProfileViewController {
    
    func setupImage() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
    }
}

// MARK: - Label

extension ProfileViewController {
    
    func setupLabel() {
        usernameLabel.text = "Some user"
    }
}


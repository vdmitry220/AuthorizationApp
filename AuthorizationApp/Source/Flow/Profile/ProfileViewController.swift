import UIKit
import Rswift

class ProfileViewController: UIViewController {
    
    private var viewModel: ProfileViewModel!
    
    private var infoUserStackView = UIStackView()
    private var menuStackView = UIStackView()
    private var avatarImageView = UIImageView(image: R.image.avatar())
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Some user"
        return label
    }()
    
    private var helpButton = CustomButton(
        title: "Help",
        color: .clear,
        borderColor: .black)
    
    private var favoritesButton = CustomButton(
        title: "Favorites",
        color: .clear,
        borderColor: .black)
    
    private var editProfileButton = CustomButton(
        title: "Edit profile",
        color: .clear,
        borderColor: .black)
    
    private var logOutButton = CustomButton(
        title: "Log out",
        color: .clear,
        borderColor: .black)
    
    private var spacing = 10.0
    private var divider = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        setup()
    }
    
    func inject(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - ProfileViewController

extension ProfileViewController {
    func setup() {
        configureStackView()
        configureMenuStackView()
        setupImage()
        setupButtons()
    }
}

// MARK: - CustomButtons

extension ProfileViewController {
    
    func setupButtons() {
        logOutButton.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)
        setEditProfileButtonConstraints()
        setContraintsBottons()
        favoritesButton.setIcon(image: R.image.star() ?? UIImage())
        helpButton.setIcon(image: R.image.help() ?? UIImage())
        logOutButton.setIcon(image: R.image.logOut() ?? UIImage())
    }
    
    func setEditProfileButtonConstraints() {
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.leadingAnchor.constraint(equalTo: infoUserStackView.leadingAnchor).isActive = true
        editProfileButton.trailingAnchor.constraint(equalTo: infoUserStackView.trailingAnchor).isActive = true
    }
    
    func setContraintsBottons() {
        [self.favoritesButton,
         self.helpButton,
         self.logOutButton].forEach { button in
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 35).isActive = true
            button.leadingAnchor.constraint(equalTo: menuStackView.leadingAnchor).isActive = true
            button.trailingAnchor.constraint(equalTo: menuStackView.trailingAnchor).isActive = true
        }
    }
    
    @objc func logOutButtonPressed() {
        viewModel.logOut()
    }
}

// MARK: - UIStackView

extension ProfileViewController {
    func configureStackView() {
        view.addSubview(infoUserStackView)
        
        infoUserStackView.axis = .vertical
        infoUserStackView.alignment = .center
        infoUserStackView.distribution = .fill
        infoUserStackView.spacing = spacing
        infoUserStackView.backgroundColor = .lightGray
        infoUserStackView.layer.cornerRadius = 8
        
        [
            self.avatarImageView,
            self.usernameLabel,
            self.editProfileButton
        ]
            .forEach { infoUserStackView.addArrangedSubview($0) }
        
        setStackViewConstraints()
    }
    
    func setStackViewConstraints() {
        infoUserStackView.translatesAutoresizingMaskIntoConstraints = false
        infoUserStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        infoUserStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        infoUserStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    func configureMenuStackView() {
        view.addSubview(menuStackView)
        
        menuStackView.axis = .vertical
        menuStackView.alignment = .center
        menuStackView.distribution = .fill
        menuStackView.spacing = spacing
        menuStackView.backgroundColor = .lightGray
        menuStackView.layer.cornerRadius = 8
        
        [
            self.favoritesButton,
            self.helpButton,
            self.logOutButton
        ]
            .forEach { menuStackView.addArrangedSubview($0) }
        
        setMenuStackViewConstraints()
    }
    
    func setMenuStackViewConstraints() {
        menuStackView.translatesAutoresizingMaskIntoConstraints = false
        menuStackView.topAnchor.constraint(equalTo: infoUserStackView.bottomAnchor, constant: 15).isActive = true
        menuStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        menuStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
}

// MARK: - UIImageView

extension ProfileViewController {
    
    func setupImage() {
        avatarImageView.layer.cornerRadius = 40
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.darkGray.cgColor
    }
}



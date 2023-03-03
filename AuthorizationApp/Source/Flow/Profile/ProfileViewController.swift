import UIKit

class ProfileViewController: UIViewController {
    
    private var viewModel: ProfileViewModel!
    
    private var logOutButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemCyan
        self.view.addSubview(logOutButton)
        setupButton()
        setButtonConstraints()
    }
    
    func inject(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
}

extension ProfileViewController {
    
    func setupButton() {
        logOutButton.setupButton(color: .clear, borderColor: .black, title: "Log out")
        logOutButton.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)
    }
    
    func setButtonConstraints() {
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    @objc func logOutButtonPressed() {
        viewModel.logOut()
    }
}

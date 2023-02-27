import UIKit

class LoginViewController: UIViewController {
    
    private var username = UITextField()
    private var login = UITextField()
    private var password = UITextField()
    private var createAccountButton = UIButton()
    private var stackView = UIStackView()
    
    private var viewModel: AuthViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindState()
        view.backgroundColor = .darkGray
        configureStackView()
        setupTextField()
    }
    
    func inject(viewModel: AuthViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - StackView

extension LoginViewController {
    
    func configureStackView() {
        view.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        stackView.addArrangedSubview(login)
        stackView.addArrangedSubview(username)
        stackView.addArrangedSubview(password)
        stackView.addArrangedSubview(createAccountButton)
        
        setStackViewConstraints()
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
}

// MARK: - TextField

extension LoginViewController {
    
    func configureTextField(textField: UITextField, color: UIColor, placeholder: String) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = color
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        textField.placeholder = placeholder
    }
    
    func setupTextField() {
        
        configureTextField(
            textField: username,
            color: .white,
            placeholder: "User name")
        
        configureTextField(
            textField:
                login, color: .white,
            placeholder: "Email")
        
        configureTextField(
            textField: password,
            color: .white,
            placeholder: "Password")
    }
}

// MARK: - Button

extension LoginViewController {
    
    func setupButton(_ title: String) {
        createAccountButton.setupButton(color: .systemBlue, title: title)
    }
}

// MARK: - Bind

extension LoginViewController {
    
    func bindState() {
        viewModel.authState.bind(listener: { state in
            DispatchQueue.main.async {
                if state == AuthState.signIn {
                    self.navigationItem.title = "Sign in"
                    self.username.isHidden = true
                    self.setupButton("Sign in")
                } else {
                    self.navigationItem.title = "Sign up"
                    self.username.isHidden = false
                    self.setupButton("Create a new account")
                }
            }
        })
    }
}

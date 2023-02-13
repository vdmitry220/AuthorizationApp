import UIKit

class SignUpViewController: UIViewController {
    
    private var userName = UITextField()
    private var login = UITextField()
    private var password = UITextField()
    private var createAccountButton = UIButton()
    private var stackView = UIStackView()
    
    private var viewModel: SignUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        configureStackView()
        setupTextField()
        setupButton()
    }
    
    func inject(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - StackView

extension SignUpViewController {
    
    func configureStackView() {
        view.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        stackView.addArrangedSubview(login)
        stackView.addArrangedSubview(userName)
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

extension SignUpViewController {
    
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
            textField: userName,
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

extension SignUpViewController {
    
    func setupButton() {
        createAccountButton.setupButton(color: .systemBlue, title: "Create a new account")
    }
}

import UIKit

class SignInViewController: UIViewController {
    
    private var login = UITextField()
    private var password = UITextField()
    private var signIn = UIButton()
    private var stackView = UIStackView()
    
    private var viewModel: SignInViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .brown
        configureStackView()
        setupTextField()
        setupButton()
    }
    
    func inject(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - StackView

extension SignInViewController {
    
    func configureStackView() {
        view.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        stackView.addArrangedSubview(login)
        stackView.addArrangedSubview(password)
        stackView.addArrangedSubview(signIn)
        
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

extension SignInViewController {
    
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
            textField:
                login, color: .white,
            placeholder: "Email")
        
        configureTextField(
            textField: password,
            color: .white,
            placeholder: "Password")
    }
    
    func setupButton() {
        signIn.setupButton(color: .systemBlue, title: "Sign in")
    }
}

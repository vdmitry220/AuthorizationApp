import UIKit

class LoginViewController: UIViewController {
    
    private var loginTextField = UITextField()
    private var passwordTextField = UITextField()
    private var loginButton = UIButton()
    private var loginErrorDescriptionLabel = UILabel()
    private var stackView = UIStackView()
    
    private var viewModel: AuthViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        bindState()
        configureStackView()
        setupTextField()
        setDelegates()
        bindData()
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
        stackView.addArrangedSubview(loginErrorDescriptionLabel)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        
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
        textField.layer.cornerRadius = 3
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.placeholder = placeholder
    }
    
    func setupTextField() {
        
        configureTextField(
            textField: loginTextField,
            color: .white,
            placeholder: "Email")
        
        configureTextField(
            textField: passwordTextField,
            color: .white,
            placeholder: "Password")
    }
    
    func setDelegates() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
}

// MARK: - Button

extension LoginViewController {
    
    func setupButton(_ title: String) {
        loginButton.setupButton(
            color: .systemBlue,
            borderColor: .clear,
            title: title)
        
        loginButton.addTarget(
            self,
            action: #selector(loginButtonPressed),
            for: .touchUpInside)
    }
    
    @objc func loginButtonPressed() {
        //Here we ask viewModel to update model with existing credentials from text fields
        viewModel.updateCredentials(username: loginTextField.text!, password: passwordTextField.text!)
        
        //Here we check user's credentials input - if it's correct we call login()
        switch viewModel.credentialsInput() {
            
        case .Correct:
            login()
        case .Incorrect:
            return
        }
    }
    
    func login() {
        viewModel.signIn()
    }
}

// MARK: - Bind

extension LoginViewController {
    
    func bindState() {
        viewModel.authState.bind(listener: { state in
            DispatchQueue.main.async {
                if state == AuthState.signIn {
                    self.navigationItem.title = "Sign in"
                    self.setupButton("Sign in")
                } else {
                    self.navigationItem.title = "Sign up"
                    self.setupButton("Create a new account")
                }
            }
        })
    }
}

// MARK: - BindData

extension LoginViewController {
    
    func bindData() {
        viewModel.credentialsInputErrorMessage.bind { [weak self] in
            self?.loginErrorDescriptionLabel.isHidden = false
            self?.loginErrorDescriptionLabel.text = $0
        }
        
        viewModel.isUsernameTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.highlightTextField(self!.loginTextField)}
        }
        
        viewModel.isPasswordTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.highlightTextField(self!.passwordTextField)}
        }
        
        viewModel.errorMessage.bind {
            guard let errorMessage = $0 else { return }
            //Handle presenting of error message (e.g. UIAlertController)
        }
    }
    
    func highlightTextField(_ textField: UITextField) {
        textField.resignFirstResponder()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.cornerRadius = 3
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        loginTextField.layer.borderWidth = 0
        passwordTextField.layer.borderWidth = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

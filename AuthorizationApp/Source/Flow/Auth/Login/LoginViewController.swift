import UIKit

class LoginViewController: UIViewController {
    
    private var loginTextField = UITextField()
    private var passwordTextField = UITextField()
    private var usernameTextField = UITextField()
    private var loginErrorDescriptionLabel = UILabel()
    private var stackView = UIStackView()
    private var backgroundVideoView = BackgroundVideoView(video: "background", type: .mp4)

    private var loginButton = CustomButton(
        title: "",
        color: .clear,
        borderColor: .clear)
    
    private var viewModel: AuthViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindState()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backgroundVideoView.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        backgroundVideoView.pause()
    }
    
    func inject(viewModel: AuthViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - LoginViewController

extension LoginViewController {
    
    func setup() {
        setupBackground()
        configureStackView()
        setupTextField()
        setDelegates()
        setupLabel()
    }
    
    func setupBackground() {
        self.view.addSubview(backgroundVideoView)
        backgroundVideoView.frame = self.view.frame
    }
}

// MARK: - UIStackView

extension LoginViewController {
    
    func configureStackView() {
        view.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        stackView.addArrangedSubview(loginErrorDescriptionLabel)
        [
            usernameTextField,
            loginTextField,
            passwordTextField,
            loginButton
        ]
            .forEach { stackView.addArrangedSubview($0) }
        
        setStackViewConstraints()
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
}

// MARK: - UITextField

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
        
        configureTextField(
            textField: usernameTextField,
            color: .white,
            placeholder: "Username")
    }
    
    func setDelegates() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
        usernameTextField.delegate = self
    }
    
    
    func highlightTextField(_ textField: UITextField) {
        textField.resignFirstResponder()
        textField.layer.cornerRadius = 3
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.red.cgColor
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        usernameTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        loginTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderWidth = 1.0
        usernameTextField.layer.borderWidth = 1.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - CustomButton

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
        viewModel.updateCredentials(
            login: loginTextField.text!,
            password: passwordTextField.text!,
            username: usernameTextField.text!
        )
        
        switch viewModel.credentialsInput() {
            
        case .Correct:
            login()
        case .Incorrect:
            loginButton.shake()
            return
        }
    }
}

// MARK: - UILabel

extension LoginViewController {
    
    func setupLabel() {
        loginErrorDescriptionLabel.numberOfLines = 0
        loginErrorDescriptionLabel.textColor = .systemRed
    }
}

// MARK: - Binding

extension LoginViewController {
    
    func bindData() {
        viewModel.credentialsInputErrorMessage.bind { [weak self] in
            self?.loginErrorDescriptionLabel.isHidden = false
            self?.loginErrorDescriptionLabel.text = $0
        }
        
        viewModel.isLoginTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.highlightTextField(self!.loginTextField)}
        }
        
        viewModel.isPasswordTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.highlightTextField(self!.passwordTextField)}
        }
        
        viewModel.isUsernameTextFieldHighLighted.bind{ [weak self] in
            if $0 { self?.highlightTextField(self!.usernameTextField)}
        }
        
        viewModel.errorMessage.bind {
            guard let errorMessage = $0 else { return }
        }
    }
    
    func bindState() {
        viewModel.authState.bind { state in
            DispatchQueue.main.async {
                if state == .signIn {
                    self.navigationItem.title = "Sign in"
                    self.setupButton("Sign in")
                    self.usernameTextField.isHidden = true
                } else {
                    self.navigationItem.title = "Sign up"
                    self.setupButton("Create a new account")
                }
            }
        }
    }
    
    func login() {
        viewModel.authState.bind { state in
            DispatchQueue.main.async {
                if state == .signUp {
                    self.viewModel.createUser()
                } else {
                    self.viewModel.signIn()
                }
            }
        }
    }
}





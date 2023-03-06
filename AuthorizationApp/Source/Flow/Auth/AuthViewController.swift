import UIKit

class AuthViewController: UIViewController {
    
    private var stackView = UIStackView()
    private var signUp = CustomButton(
        title: "Sign up with email",
        color: .clear,
        borderColor: .black)
    
    private var signIn = CustomButton(
        title: "Sign in",
        color: .clear,
        borderColor: .black)
    
    private var viewModel: AuthViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        setupSignUpBotton()
        configureStackView()
    }
    
    func inject(viewModel: AuthViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - StackView

extension AuthViewController {
    
    func configureStackView() {
        view.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        stackView.addArrangedSubview(signUp)
        stackView.addArrangedSubview(signIn)
        
        setStackViewConstraints()
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
}

// MARK: - Buttons

extension AuthViewController {
    
    func setupSignUpBotton() {
        
        signUp.addTarget(
            self,
            action: #selector(signUpButtonWasTapped),
            for: .touchUpInside)
        
        signIn.addTarget(
            self,
            action: #selector(signInButtonWasTapped),
            for: .touchUpInside)
    }
    
    @objc func signUpButtonWasTapped() {
        self.viewModel.startSignUp()
    }
    
    @objc func signInButtonWasTapped() {
        self.viewModel.startSignIn()
    }
}



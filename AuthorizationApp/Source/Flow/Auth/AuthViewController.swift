import UIKit
import AVFoundation

class AuthViewController: UIViewController {
    
    private var stackView = UIStackView()
    private var backgroundVideoView = BackgroundVideoView(video: "background", type: .mp4)
    
    private var signUp = CustomButton(
        title: "Sign up with email",
        color: .clear,
        borderColor: .white)
    
    private var signIn = CustomButton(
        title: "Sign in",
        color: .clear,
        borderColor: .white)
    
    private var viewModel: AuthViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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

// MARK: - AuthViewController

extension AuthViewController {
    
    func setup() {
        setupBackground()
        setupSignUpBotton()
        configureStackView()
    }
    
    func setupBackground() {
        view.addSubview(backgroundVideoView)
        backgroundVideoView.frame = self.view.frame
    }
}

// MARK: - UIStackView

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

// MARK: - CustomButtons

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



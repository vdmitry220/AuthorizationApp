import UIKit
import AVFoundation

class AuthViewController: UIViewController {
    
    private var stackView = UIStackView()
    private var player: AVPlayer?
    
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
        playBackgroundVideo()
    }
    
    func inject(viewModel: AuthViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - AuthViewController

extension AuthViewController {
    
    func setup() {
        view.backgroundColor = .gray
        setupSignUpBotton()
        configureStackView()
    }
    
    func playBackgroundVideo() {
        guard let path = Bundle.main.path(forResource: "background", ofType: ".mp4") else { return }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        player?.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let palyerLayer = AVPlayerLayer(player: player)
        palyerLayer.frame = self.view.frame
        palyerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(palyerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(palayVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        player?.seek(to: CMTime.zero)
        player?.play()
        self.player?.isMuted = true
    }
    
    @objc func palayVideo() {
        player?.seek(to: CMTime.zero)
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



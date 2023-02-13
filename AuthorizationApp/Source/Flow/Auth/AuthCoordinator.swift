
import Foundation
import Swinject
import SwinjectAutoregistration

class AuthCoordinator {
    
    private let resolver: Resolver
    let navigationController = UINavigationController()
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
}

// MARK: - Start

extension AuthCoordinator: Coordinator {
    
    var root: UIViewController {
        self.navigationController
    }
    
    func start() {
        let authViewController = resolver ~> AuthViewController.self
        self.navigationController.setViewControllers([authViewController], animated: false)
    }
    
    func navigate(_ route: Route) {
        switch route {
        case .signUp:
            pushSignUp()
        case .signIn:
            pushSingIn()
        default:
            break
        }
    }
}

// MARK: - Open

extension AuthCoordinator {
    
    func pushSignUp() {
        let signUpViewController = resolver ~> SignUpViewController.self
        self.navigationController.pushViewController(signUpViewController, animated: true)
    }
    
    func pushSingIn() {
        let signInViewController = resolver ~> SignInViewController.self
        self.navigationController.pushViewController(signInViewController, animated: true)
    }
}


import Foundation
import Swinject
import SwinjectAutoregistration

class AuthCoordinator {
    
    private let resolver: Resolver
    let navigationController = UINavigationController()
    var finishFlow: ((Route)->())?
    
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
        let authViewController = resolver.resolve(AuthViewController.self, argument: Observable(AuthState.signUp))!
        self.navigationController.setViewControllers([authViewController], animated: false)
    }
    
    func navigate(_ route: Route) {
        switch route {
        case .signUp:
            pushSignUp()
        case .signIn:
            pushSignIn()
        case .home:
            finishFlow?(route)
        default:
            break
        }
    }
}

// MARK: - Open

extension AuthCoordinator {
    
    func pushSignUp() {
        let signUpViewController = resolver.resolve(LoginViewController.self, argument: Observable(AuthState.signUp))!
        self.navigationController.pushViewController(signUpViewController, animated: true)
    }
    
    func pushSignIn() {
        let signInViewController = resolver.resolve(LoginViewController.self, argument: Observable(AuthState.signIn))!
        self.navigationController.pushViewController(signInViewController, animated: true)
    }
    
    func pushHome() {
        
    }
}

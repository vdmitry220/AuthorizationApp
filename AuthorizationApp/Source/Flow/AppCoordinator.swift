import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration
import Rswift

class AppCoordinator {
    
    var window: UIWindow?
    private let resolver: Resolver
    private let sessionService: SessionService
    
    let tabBarController = UITabBarController()
    var rootViewController: UIViewController {
        get {
            window?.rootViewController ?? UIViewController()
        }
        set {
            window?.rootViewController = newValue
        }
    }
        
    var initialRoute: Route {
        if sessionService.isSessionExpired() {
            sessionService.clearSession()
            return .auth
        } else {
            return .home
        }
    }
    
    init(
        resolver: Resolver,
        sessionService: SessionService) {
            
        self.resolver = resolver
        self.sessionService = sessionService
    }
}

// MARK: - Start

extension AppCoordinator: Coordinator {
    
    var root: UIViewController {
        setRoot()
    }
    
    func start() {
        navigate(initialRoute)
    }
    
    func navigate(_ route: Route) {
        switch route {
        case .auth:
            showAuthView()
        case .home:
            showHomeView()
        default:
            break
        }
    }
}

// MARK: - ShowView

extension AppCoordinator {
    
    func showHomeView() {
        let homeCoordinator = resolver ~> HomeCoordinator.self
        let profileCoordinator = resolver ~> ProfileCoordinator.self
        
        self.tabBarController.setViewControllers([homeCoordinator.root, profileCoordinator.root], animated: false)
        homeCoordinator.start()
        profileCoordinator.start()
        setupTapBar(with: [homeCoordinator.root, profileCoordinator.root])
        rootViewController = tabBarController
        profileCoordinator.finishFlow = { self.navigate($0) }
    }
    
    func showAuthView() {
        let authCoordinator = resolver ~> AuthCoordinator.self
        authCoordinator.start()
        rootViewController = authCoordinator.root
        authCoordinator.finishFlow = { self.navigate($0) }
    }
    
    func setRoot() -> UIViewController {
        rootViewController
    }
}

// MARK: - Private

private extension AppCoordinator {
    
    func setupTapBar(with viewControllers: [UIViewController]) {
        viewControllers.first?.tabBarItem = UITabBarItem(title: "Home", image: .actions, tag: 0)
        viewControllers.last?.tabBarItem = UITabBarItem(title: "Profile", image: .checkmark, tag: 1)
    }
}

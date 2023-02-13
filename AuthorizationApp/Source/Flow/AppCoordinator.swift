import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration
import Rswift

class AppCoordinator {
    
    private let resolver: Resolver
    
    let tabBarController = UITabBarController()
    
    var isLoggedIn: Bool = false
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
}

// MARK: - Start

extension AppCoordinator: Coordinator {
    
    var root: UIViewController {
        setRoot()
    }
    
    func start() {
        if isLoggedIn == true {
            showMainView()
        } else {
            showAuthView()
        }
    }
    
    func navigate(_ route: Route) {
        
    }
}

// MARK: - ShowView

extension AppCoordinator {
    
    func showMainView() {
        let homeCoordinator = resolver ~> HomeCoordinator.self
        
        self.tabBarController.setViewControllers([homeCoordinator.root], animated: false)
        homeCoordinator.start()
        setupTapBar(with: [homeCoordinator.root])
    }
    
    func showAuthView() {
        let authCoordinator = resolver ~> AuthCoordinator.self
        authCoordinator.start()
    }
    
    func setRoot() -> UIViewController {
        let authCoordinator = resolver ~> AuthCoordinator.self
        
        if isLoggedIn == true {
            return tabBarController
        } else {
            return authCoordinator.root
        }
    }
}

// MARK: - Private

private extension AppCoordinator {
    
    func setupTapBar(with viewControllers: [UIViewController]) {
        viewControllers.first?.tabBarItem = UITabBarItem(title: "Home", image: .actions, tag: 0)
    }
}

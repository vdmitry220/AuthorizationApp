import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration
import Rswift

class AppCoordinator {
    
    private let resolver: Resolver
    private let sessionService: SessionService
    
    let tabBarController = UITabBarController()
        
    var initialStep: Bool {
        if sessionService.isSessionExpired() {
            sessionService.clearSession()
            return false
        } else {
            return true
        }
    }
    
    init(resolver: Resolver, sessionService: SessionService) {
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
        if initialStep == true {
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
        
        if initialStep == true {
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

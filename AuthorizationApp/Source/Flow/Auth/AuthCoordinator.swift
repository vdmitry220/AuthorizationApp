
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
}

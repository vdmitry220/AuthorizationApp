

import Foundation
import Swinject
import SwinjectAutoregistration

class HomeCoordinator {
    
    private let resolver: Resolver
    let navigationController = UINavigationController()
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
}

// MARK: - Start

extension HomeCoordinator: Coordinator {
    
    var root: UIViewController {
        self.navigationController
    }
    
    func start() {
        let homeViewController = resolver ~> HomeViewController.self
        self.navigationController.setViewControllers([homeViewController], animated: false)
    }
    
    func navigate(_ route: Route) {
        
    }
}

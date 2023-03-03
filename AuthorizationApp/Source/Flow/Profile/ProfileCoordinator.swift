import Foundation
import Swinject
import SwinjectAutoregistration

class ProfileCoordinator {
    
    private let resolver: Resolver
    let navigationController = UINavigationController()
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
}

// MARK: - Start

extension ProfileCoordinator: Coordinator {
    
    var root: UIViewController {
        self.navigationController
    }
    
    func start() {
        let profileViewController = resolver ~> ProfileViewController.self
        self.navigationController.setViewControllers([profileViewController], animated: false)
    }
    
    func navigate(_ route: Route) {

    }
}

// MARK: - Navigate

extension ProfileCoordinator {

}

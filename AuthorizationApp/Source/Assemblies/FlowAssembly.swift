import Foundation
import Swinject
import SwinjectAutoregistration

class FlowAssembly {
    
}

// MARK: - FlowAssembly

extension FlowAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(AppCoordinator.self) { (resolver) in
            AppCoordinator(
                resolver: resolver,
                sessionService: resolver~>)
        }.inObjectScope(.container)
        
        container.register(AuthCoordinator.self) { (resolver) in
            AuthCoordinator(resolver: resolver)
        }.inObjectScope(.container)
        
        container.register(HomeCoordinator.self) { (resolver) in
            HomeCoordinator(resolver: resolver)
        }.inObjectScope(.container)
    }
}

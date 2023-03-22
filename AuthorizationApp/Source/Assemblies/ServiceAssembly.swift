import Foundation
import Swinject
import SwinjectAutoregistration

class ServiceAssembly {}

// MARK: - Assembly

extension ServiceAssembly: Assembly {
    func assemble(container: Container) {
        assembleUserDefaults(container: container)
        assemblyUserDataService(container: container)
        assemblySessionService(container: container)
        assembleAuthorizationService(container: container)
    }
}

// MARK: - PrivateAssembly

private extension ServiceAssembly {
    
    func assemblySessionService(container: Container) {
        container.autoregister(SessionService.self, initializer: SessionServiceImp.init).inObjectScope(.container)
    }
    
    func assemblyUserDataService(container: Container) {
        container.autoregister(UserDataService.self, initializer: UserDataServiceImp.init).inObjectScope(.container)
    }

    func assembleUserDefaults(container: Container) {
        container.autoregister(UserDefaultsService.self, initializer: UserDefaultsServiceImp.init).inObjectScope(.container)
    }
    
    func assembleAuthorizationService(container: Container) {
        container.autoregister(AuthorizationService.self, initializer: AuthorizationServiceImp.init).inObjectScope(.container)
    }
}


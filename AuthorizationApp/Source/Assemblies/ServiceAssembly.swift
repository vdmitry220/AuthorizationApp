import Foundation
import Swinject
import SwinjectAutoregistration

class ServiceAssembly {}

// MARK: - Assembly

extension ServiceAssembly: Assembly {
    func assemble(container: Container) {
        assembleUserDefaults(container: container)
    }
}

// MARK: - PrivateAssembly

private extension ServiceAssembly {
    func assembleUserDefaults(container: Container) {
        container.autoregister(UserDefaultsService.self, initializer: UserDefaultsServiceImp.init).inObjectScope(.container)
    }
}


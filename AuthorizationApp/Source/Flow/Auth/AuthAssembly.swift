
import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration
import Rswift

class AuthAssembly {}

extension AuthAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AuthViewController.self) { resolver in
            
            let viewModel = resolver ~> AuthViewModel.self
            let view = AuthViewController()
            view.inject(viewModel: viewModel)
            
            return view
        }
        
        container.register(AuthViewModel.self) { resolver in
            let coordinator = resolver ~> AuthCoordinator.self
            
            return AuthViewModel(coordinator: coordinator)
            
        }
    }
}

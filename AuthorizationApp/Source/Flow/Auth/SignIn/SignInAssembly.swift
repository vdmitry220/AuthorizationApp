import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration
import Rswift

class SignInAssembly {}

extension SignInAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(SignInViewController.self) { resolver in
            
            let viewModel = resolver ~> SignInViewModel.self
            let view = SignInViewController()
            view.inject(viewModel: viewModel)
            
            return view
        }
        
        container.register(SignInViewModel.self) { resolver in
            let coordinator = resolver ~> AuthCoordinator.self
            
            return SignInViewModel(coordinator: coordinator)
            
        }
    }
}

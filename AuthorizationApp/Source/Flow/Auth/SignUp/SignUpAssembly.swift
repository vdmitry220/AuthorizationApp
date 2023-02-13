import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration
import Rswift

class SignUpAssembly {}

extension SignUpAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(SignUpViewController.self) { resolver in
            
            let viewModel = resolver ~> SignUpViewModel.self
            let view = SignUpViewController()
            view.inject(viewModel: viewModel)
            
            return view
        }
        
        container.register(SignUpViewModel.self) { resolver in
            let coordinator = resolver ~> AuthCoordinator.self
            
            return SignUpViewModel(coordinator: coordinator)
            
        }
    }
}

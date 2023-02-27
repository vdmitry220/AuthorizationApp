import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration
import Rswift

class AuthAssembly {}

extension AuthAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AuthViewController.self) { (resolver, state: Observable<AuthState>) in
            
            let viewModel = resolver.resolve(AuthViewModel.self, argument: state)!
            let view = AuthViewController()
            view.inject(viewModel: viewModel)
            
            return view
        }
        
        container.register(LoginViewController.self) { (resolver, state: Observable<AuthState>) in
            
            let viewModel = resolver.resolve(AuthViewModel.self, argument: state)!
            let view = LoginViewController()
            view.inject(viewModel: viewModel)
            
            return view
        }
        
        container.register(AuthViewModel.self) { (resolver, state: Observable<AuthState>) in
            let coordinator = resolver.resolve(AuthCoordinator.self)!
            let userDefaults = resolver.resolve(UserDefaultsService.self)!
            
            return AuthViewModel(
                coordinator: coordinator,
                userDefaults: userDefaults,
                authState: state)
            
        }
    }
}

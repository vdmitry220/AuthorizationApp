import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration

class ProfileAssembly {}

extension ProfileAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ProfileViewController.self) { resolver in
            
            let viewModel = resolver.resolve(ProfileViewModel.self)!
            let view = ProfileViewController()
            view.inject(viewModel: viewModel)
            
            return view
        }
        
        container.register(ProfileViewModel.self) { resolver in
            let coortinator = resolver.resolve(ProfileCoordinator.self)!
            
            return ProfileViewModel(
                coordinator: coortinator,
                userDataService: resolver~>)
        }
    }
}

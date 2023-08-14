import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration
import Rswift

class HomeAssembly {}

extension HomeAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(HomeViewController.self) { resolver in
            
            let view = HomeViewController()
            let viewModel = resolver.resolve(HomeViewModel.self)!
            view.inject(viewModel: viewModel)
            
            return view
        }
        
        container.register(HomeViewModel.self) { resolver in
            let coordinator = resolver ~> HomeCoordinator.self
            
            return HomeViewModel(
                coordinator: coordinator,
                authorizationService: resolver~>,
                videoApiService: resolver~>
            )
        }
    }
}

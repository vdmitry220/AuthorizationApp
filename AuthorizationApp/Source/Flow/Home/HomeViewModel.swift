import Foundation
import Rswift

class HomeViewModel {
    
    private weak var coordinator: Coordinator?
    private weak var authorizationService: AuthorizationService?
    
    init(
        coordinator: Coordinator,
        authorizationService: AuthorizationService
    ){
        self.coordinator = coordinator
        self.authorizationService = authorizationService
    }
}

// MARK: HomeViewModel

extension HomeViewModel {}




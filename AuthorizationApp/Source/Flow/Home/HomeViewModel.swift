import Foundation
import Rswift
import AVKit

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

// MARK: - Navigate

extension HomeViewModel {

}




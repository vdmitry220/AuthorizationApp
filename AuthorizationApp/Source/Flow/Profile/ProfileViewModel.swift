import Foundation
import FirebaseAuth

class ProfileViewModel {
    
    private weak var coordinator: ProfileCoordinator?
    private weak var userDataService: UserDataService?
    private weak var authorizationService: AuthorizationService?
    
    init(
        coordinator: ProfileCoordinator,
        userDataService: UserDataService,
        authorizationService: AuthorizationService) {
            
            self.coordinator = coordinator
            self.userDataService = userDataService
            self.authorizationService = authorizationService
        }
}

// MARK: - Navigate

extension ProfileViewModel {
    
    func logOut() {
        userDataService?.credentials = nil
        coordinator?.navigate(.auth)
        exit()
    }
}

// MARK: - AuthorizationService

extension ProfileViewModel {
    func exit() {
        DispatchQueue.main.async {
            self.authorizationService?.logOut()
        }
    }
}



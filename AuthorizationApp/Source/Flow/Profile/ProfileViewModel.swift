import Foundation

class ProfileViewModel {
    
    private weak var coordinator: ProfileCoordinator?
    private weak var userDataService: UserDataService?
    
    init(
        coordinator: ProfileCoordinator,
        userDataService: UserDataService?) {
            
        self.coordinator = coordinator
        self.userDataService = userDataService
    }
}

// MARK: - Navigate

extension ProfileViewModel {
    
    func logOut() {
        userDataService?.credentials = nil
        coordinator?.navigate(.auth)
    }
}



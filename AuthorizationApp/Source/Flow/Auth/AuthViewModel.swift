import Foundation
import Rswift

class AuthViewModel {
    
    private weak var coordinator: Coordinator?
    private weak var userDefaults: UserDefaultsService?
    
    var authState: Observable<AuthState> = Observable(AuthState.signUp)
    
    init(
        coordinator: Coordinator,
        userDefaults: UserDefaultsService,
        authState: Observable<AuthState>) {
            
            self.coordinator = coordinator
            self.userDefaults = userDefaults
            self.authState = authState
        }
}



extension AuthViewModel {

}

// MARK: - Navigate

extension AuthViewModel {
    
    func startSignUp() {
        coordinator?.navigate(.signUp)
    }
    
    func startSignIn() {
        coordinator?.navigate(.signIn)
    }
}


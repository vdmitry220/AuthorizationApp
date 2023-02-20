import Foundation
import Rswift

class AuthViewModel {
        
    private weak var coordinator: Coordinator?
    var authState: Observable<AuthState> = Observable(AuthState.signUp)
        
    init(
        coordinator: Coordinator,
        authState: Observable<AuthState>) {
            
        self.coordinator = coordinator
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

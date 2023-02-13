import Foundation
import Rswift

class AuthViewModel {
    
    private weak var coordinator: Coordinator?
        
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        
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

import Foundation
import Rswift

enum CredentialsInputStatus {
    case Correct
    case Incorrect
}

class AuthViewModel {
    
    private weak var coordinator: Coordinator?
    private weak var userDataService: UserDataService?
    private weak var authorizationService: AuthorizationService?
    
    var authState: Observable<AuthState> = Observable(AuthState.signUp)
    
    private var credentials = Credentials() {
        didSet {
            login = credentials.login
            password = credentials.password
            username = credentials.username
        }
    }
    
    private var login = ""
    private var password = ""
    private var username = ""
    
    var credentialsInputErrorMessage: Observable<String> = Observable("")
    var isLoginTextFieldHighLighted: Observable<Bool> = Observable(false)
    var isPasswordTextFieldHighLighted: Observable<Bool> = Observable(false)
    var isUsernameTextFieldHighLighted: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String?> = Observable(nil)
    
    init(
        coordinator: Coordinator,
        userDataService: UserDataService,
        authorizationService: AuthorizationService,
        authState: Observable<AuthState>) {
            
            self.coordinator = coordinator
            self.authState = authState
            self.userDataService = userDataService
            self.authorizationService = authorizationService
        }
}

// MARK: - Navigate

extension AuthViewModel {
    
    func startSignUp() {
        coordinator?.navigate(.signUp)
    }
    
    func startSignIn() {
        coordinator?.navigate(.signIn)
    }
    
    func startHome() {
        coordinator?.navigate(.home)
    }
}

// MARK: - Login

extension AuthViewModel {
    
    func createUser() {
        if isPasswordValid(credentials.password) {
            authorizationService?.createNewAccount(with: credentials) { user, error in
                if error != nil {
                    print(error)
                } else {
                    self.signIn()
                }
            }
        } else {
            print("Password must have minimum 8 characters at least 1 Alphabet and 1 Number")
        }
    }
    
    func signIn() {
        DispatchQueue.main.async {
            self.authorizationService?.signIn(with: self.credentials) { user, error in
                if user != nil {
                    self.userDataService?.credentials = self.credentials
                    self.startHome()
                } else {
                    print("User not found")
                }
            }
        }
    }
}

// MARK: - CredentialsInputStatus

extension AuthViewModel {
    
    func credentialsInput() -> CredentialsInputStatus {
        if login.isEmpty && password.isEmpty && username.isEmpty {
            credentialsInputErrorMessage.value = "Please provide all credentials"
            return .Incorrect
        }
        if login.isEmpty {
            credentialsInputErrorMessage.value = "Username field is empty"
            isLoginTextFieldHighLighted.value = true
            return .Incorrect
        }
        if password.isEmpty {
            credentialsInputErrorMessage.value = "Password field is empty"
            isPasswordTextFieldHighLighted.value = true
            return .Incorrect
        }
        
        if username.isEmpty {
            if authState.value == .signUp {
                credentialsInputErrorMessage.value = "Username field is empty"
                isUsernameTextFieldHighLighted.value = true
                return .Incorrect
            } else {
                return .Correct
            }
        }
        return .Correct
    }
    
    func updateCredentials(
        login: String,
        password: String,
        username: String,
        otp: String? = nil)
    {
        credentials.login = login
        credentials.password = password
        credentials.username = username
    }
}

// MARK: - Validation

extension AuthViewModel {
    
    private func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")
        return passwordTest.evaluate(with: password)
    }
    
    

}

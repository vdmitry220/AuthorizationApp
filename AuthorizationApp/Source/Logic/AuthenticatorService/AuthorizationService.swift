import Foundation
import FirebaseAuth
import Firebase

protocol AuthorizationService: AnyObject {
    var user: User? { get }
    
    func createNewAccount(with credentials: Credentials, completion: @escaping (_ user: User?, _ error: String?) -> ())
    func signIn(with credentials: Credentials,  completion: @escaping (_ user: User?, _ error: String?) -> ())
    func addUserState()
    func logOut()
}

class AuthorizationServiceImp {
    let authorizer = Auth.auth()
    let dataBase = Database.database()
}

// MARK: - Authorization

extension AuthorizationServiceImp: AuthorizationService {
    
    var user: User? {
        authorizer.currentUser
    }
    
    func createNewAccount(with credentials: Credentials, completion: @escaping (_ user: User?, _ error: String?) -> ()) {
        authorizer.createUser(withEmail: credentials.login, password: credentials.password) { (result, error) in
            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            
            if let result = result {
                self.addUserToData(with: credentials, id: result.user.uid)
                completion(result.user, nil)
            }
        }
    }
    
    func signIn(with credentials: Credentials, completion: @escaping (_ user: User?, _ error: String?) -> ()) {
        authorizer.signIn(withEmail: credentials.login, password: credentials.password) { (result, error) in
            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            
            if let result = result {
                completion(result.user, nil)
            }
        }
    }
    
    func logOut() {
        do {
            try authorizer.signOut()
            print("User logged out")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addUserState() {
        authorizer.addStateDidChangeListener { auth, user in
            
        }
    }
}

// MARK: - DataBase

private extension AuthorizationServiceImp {
    
    func addUserToData(with credentials: Credentials, id: String) {
        let reference = dataBase.reference().child("users")
        reference.child(id).updateChildValues(["username": credentials.username, "email" : credentials.login])
    }
}

import Foundation

protocol UserDataService: AnyObject {
    
    var credentials: Credentials? { get set }
}

class UserDataServiceImp {
    
    private let userDefaults: UserDefaultsService
    
    init(userDefaults: UserDefaultsService) {
        self.userDefaults = userDefaults
    }
}

extension UserDataServiceImp: UserDataService {
    
    var credentials: Credentials? {
        get {
            userDefaults.value(type: Credentials.self, for: .credentials)
        }
        set {
            userDefaults.save(newValue, for: .credentials)
        }
    }
    
    private var defaultValue: Credentials {
        Credentials(login: "", password: "")
    }
}

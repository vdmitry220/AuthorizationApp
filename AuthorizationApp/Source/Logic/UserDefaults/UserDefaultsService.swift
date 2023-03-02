import Foundation

enum UserDefaultsKey {
    case credentials
    
    var stringValue: String {
        switch self {
        case .credentials:
            return "credentials"
        }
    }
}

protocol UserDefaultsService: AnyObject {
    
    func save<Value: Codable>(_ value: Value, for key: UserDefaultsKey)
    
    func save<Value: Codable>(_ value: Value?, for key: UserDefaultsKey)
    
    func value<Value: Codable>(type: Value.Type, for key: UserDefaultsKey) -> Value?
    
    func removeValue(for key: UserDefaultsKey)
}

final class UserDefaultsServiceImp {
    
    private let defaults = UserDefaults.standard
}

// MARK: - UserDefaultsService

extension UserDefaultsServiceImp: UserDefaultsService {
    
    func save<Value: Codable>(_ value: Value, for key: UserDefaultsKey) {
        do {
            let data = try JSONEncoder().encode(value)
            defaults.set(data, forKey: key.stringValue)
        } catch {
            logSave(value, failure: error)
        }
    }

    func save<Value: Codable>(_ value: Value?, for key: UserDefaultsKey) {
        
            if let value = value {
                save(value, for: key)
            } else {
                removeValue(for: key)
            }
        }

    func value<Value: Codable>(type: Value.Type, for key: UserDefaultsKey) -> Value? {
            if let data = defaults.value(forKey: key.stringValue) as? Data,
               let value = try? JSONDecoder().decode(type.self, from: data) {
                return value 
            }
            return nil
        }
    
    func removeValue(for key: UserDefaultsKey) {
        defaults.removeObject(forKey: key.stringValue)
    }
}

// MARK: - Log

private extension UserDefaultsServiceImp {

    func logSave(_ value: Any, failure error: Error) {
        assertionFailure("""
            Failed to save to UserDefaults:
            \(value)
            with error: \(error.localizedDescription)
            """
        )
    }
}

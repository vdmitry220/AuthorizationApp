import Foundation
import RxSwift

protocol SessionService {
    func isSessionExpired() -> Bool
    func stopSession()
    func clearSession()
}

class SessionServiceImp {
    
    private let userData: UserDataService
    private let sessionExpiredSubject = PublishSubject<()>()
    
    init(userDefaults: UserDataService) {
        self.userData = userDefaults
    }
}

// MARK: - SessionService

extension SessionServiceImp: SessionService {

    func isSessionExpired() -> Bool {
        let isSessionUserExist = userData.credentials == nil
        return isSessionUserExist
    }
    
    func stopSession() {
        clearSession()
        sessionExpiredSubject.onNext(())
    }
    
    func clearSession() {
        userData.credentials = nil
    }
}



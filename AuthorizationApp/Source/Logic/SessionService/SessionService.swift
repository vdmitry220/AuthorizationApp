import Foundation
import RxSwift

protocol SessionService {
    func isSessionExpired() -> Bool
    func stopSession()
    func clearSession()
}

class SessionServiceImp {
    
    private let userData: UserDataService
    private let authorizationService: AuthorizationService
    private let sessionExpiredSubject = PublishSubject<()>()
    
    init(
        userDefaults: UserDataService,
         authorizationService: AuthorizationService)
    {
        self.userData = userDefaults
        self.authorizationService = authorizationService
    }
}

// MARK: - SessionService

extension SessionServiceImp: SessionService {

    func isSessionExpired() -> Bool {
        let isSessionUserExist = userData.credentials == nil || authorizationService.user == nil
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



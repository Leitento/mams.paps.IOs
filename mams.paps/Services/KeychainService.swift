

import KeychainAccess
import Foundation

final class KeychainService {
    
    //MARK: - Singleton
    static let shared = KeychainService()
    
    private init() {}
    
    // MARK: - Private properties
    private let keychain = Keychain(service: "ruspersonal.mams-paps")
    private let usernameKey = "UsernameKey"
    
    // MARK: - Methods
    func saveUsernameKey(_ username: String) {
        do {
            try keychain.set(username, key: usernameKey)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteUsernameKey() {
        do {
            try keychain.remove(usernameKey)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getUsernameKey() -> String? {
        do {
            return try keychain.getString(usernameKey)
        } catch {
            print("Error retrieving encryption key from Keychain: \(error.localizedDescription)")
            return nil
        }
    }
    
}

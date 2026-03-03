//
//  HelperClass.swift
//  Rahbar India
//
//  Created by revanth kumar on 03/03/26.
//

import Foundation

final class UserSessionManager {
    
    static let shared = UserSessionManager()
    private init() {}
    
    private let userKey = "loggedInUser"
    private let tokenKey = "authToken"
    
    // MARK: - Save Session
    
    func saveSession(user: User, token: String) {
        if let encodedUser = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encodedUser, forKey: userKey)
        }
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    // MARK: - Get Token
    
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
    
    // MARK: - Get User
    
    func getUser() -> User? {
        guard let data = UserDefaults.standard.data(forKey: userKey) else { return nil }
        return try? JSONDecoder().decode(User.self, from: data)
    }
    
    // MARK: - Logout
    
    func clearSession() {
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
    // MARK: - Check Login
    
    func isLoggedIn() -> Bool {
        return getToken() != nil
    }
}

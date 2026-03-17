//
//  AuthService.swift
//  Rahbar India
//
//  Created by revanth kumar on 03/03/26.
//

import Foundation

final class AuthService {
    
    // MARK: - Singleton
    
    static let shared = AuthService()
    private init() {}
    
    
    // MARK: - Delete Account

    func deleteAccount(completion: @escaping (Result<String, Error>) -> Void) {
        
        APIManager.shared.deleteRequest(
            urlString: APIConstants.Auth.delete,
            requiresAuth: true   // ✅ token auto attached
        ) { result in
            
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(CommonResponse.self, from: data)
                    
                    if response.status == 1 {
                        
                        // Clear session after successful delete
                        UserSessionManager.shared.clearSession()
                        
                        completion(.success(response.message))
                        
                    } else {
                        completion(.failure(AuthError.apiError(response.message)))
                    }
                    
                } catch {
                    completion(.failure(AuthError.decodingFailed))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Logout

    func logout(completion: @escaping (Result<String, Error>) -> Void) {
        
        APIManager.shared.postJSONRequest(
            urlString: APIConstants.Auth.logout,
            body: [:],                // empty body
            requiresAuth: true        // ✅ token auto attached
        ) { result in
            
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(CommonResponse.self, from: data)
                    
                    if response.status == 1 {
                        
                        // ✅ Clear session locally
                        UserSessionManager.shared.clearSession()
                        
                        completion(.success(response.message))
                        
                    } else {
                        completion(.failure(AuthError.apiError(response.message)))
                    }
                    
                } catch {
                    completion(.failure(AuthError.decodingFailed))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Reset Password

    func resetPassword(
        email: String,
        token: String,
        password: String,
        passwordConfirmation: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        
        let parameters: [[String: Any]] = [
            ["key": "email", "value": email, "type": "text"],
            ["key": "token", "value": token, "type": "text"],
            ["key": "password", "value": password, "type": "text"],
            ["key": "password_confirmation", "value": passwordConfirmation, "type": "text"]
        ]
        
        APIManager.shared.postMultipartRequest(
            urlString: APIConstants.Auth.resetPassword,
            parameters: parameters,
            requiresAuth: false
        ) { result in
            
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(CommonResponse.self, from: data)
                    
                    if response.status == 1 {
                        completion(.success(response.message))
                    } else {
                        completion(.failure(AuthError.apiError(response.message)))
                    }
                    
                } catch {
                    completion(.failure(AuthError.decodingFailed))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Forgot Password

    func forgotPassword(
        email: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        
        let parameters: [[String: Any]] = [
            ["key": "email", "value": email, "type": "text"]
        ]
        
        APIManager.shared.postMultipartRequest(
            urlString: APIConstants.Auth.forgotPassword,
            parameters: parameters,
            requiresAuth: false
        ) { result in
            
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(CommonResponse.self, from: data)
                    
                    if response.status == 1 {
                        completion(.success(response.message))
                    } else {
                        completion(.failure(AuthError.apiError(response.message)))
                    }
                    
                } catch {
                    completion(.failure(AuthError.decodingFailed))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Apple Login
    
    func loginWithApple(
        appleID: String,
        email: String,
        name: String,
        identityToken: String,
        authCode: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        
        let body: [String: Any] = [
            "apple_id": appleID,
            "email": email,
            "name": name,
            "identity_token": identityToken,
            "authorization_code": authCode
        ]
        
        APIManager.shared.postJSONRequest(
            urlString: APIConstants.Auth.appleLogin,
            body: body,
            requiresAuth: false
        ) { [weak self] result in
            
            switch result {
            case .success(let data):
                self?.handleAuthResponse(data: data, completion: completion)
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    // MARK: - Login
    
    func loginUser(
        email: String,
        password: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        
        let parameters: [[String: Any]] = [
            ["key": "email", "value": email, "type": "text"],
            ["key": "password", "value": password, "type": "text"]
        ]
        
        APIManager.shared.postMultipartRequest(
            urlString: APIConstants.Auth.login,
            parameters: parameters,
            requiresAuth: false
        ) { [weak self] result in
            
            switch result {
            case .success(let data):
                self?.handleAuthResponse(data: data, completion: completion)
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    // MARK: - Register
    
    func registerUser(
        name: String,
        mobile: String,
        email: String,
        password: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        
        let parameters: [[String: Any]] = [
            ["key": "name", "value": name, "type": "text"],
            ["key": "email", "value": email, "type": "text"],
            ["key": "mobile", "value": mobile, "type": "text"],
            ["key": "password", "value": password, "type": "text"]
        ]
        
        APIManager.shared.postMultipartRequest(
            urlString: APIConstants.Auth.register,
            parameters: parameters,
            requiresAuth: false
        ) { [weak self] result in
            
            switch result {
                
            case .success(let data):
                self?.handleAuthResponse(data: data, completion: completion)
                
            case .failure(let error):
                
                if let data = (error as NSError).userInfo["data"] as? Data {
                    
                    if let apiError = try? JSONDecoder().decode(ValidationErrorResponse.self, from: data),
                       let firstError = apiError.errors?.values.first?.first {
                        
                        completion(.failure(APIError(message: firstError)))
                        return
                    }
                }
                
                completion(.failure(error))
            }
        }
    }
    
    
    
    // MARK: - Common Auth Response Handler
    
    private func handleAuthResponse(
        data: Data,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        do {
            
            // 🔹 First check validation errors
            if let validation = try? JSONDecoder().decode(ValidationErrorResponse.self, from: data),
               validation.status == 0 {

                let message = validation.errors?.values.first?.first ?? validation.message
                completion(.failure(AuthError.apiError(message)))
                return
            }
            
            // 🔹 Then decode normal login response
            let response = try JSONDecoder().decode(LoginResponse.self, from: data)
            
            guard response.status == 1 else {
                completion(.failure(AuthError.apiError(response.message)))
                return
            }
            
            guard let user = response.user,
                  let token = response.token else {
                completion(.failure(AuthError.invalidResponse))
                return
            }
            
            // Save session
            UserSessionManager.shared.saveSession(user: user, token: token)
            
            completion(.success(response.message))
            
        } catch {
            completion(.failure(AuthError.decodingFailed))
        }
    }
    
    
    // MARK: - WebView Token
    
    func fetchWebViewToken(completion: @escaping (Result<String, Error>) -> Void) {
        
        APIManager.shared.postJSONRequest(
            urlString: APIConstants.Auth.webviewToken,
            body: [:],
            requiresAuth: true
        ) { result in
            
            switch result {
                
            
            case .success(let data):
                
                
                print("🟢 API Success - Raw Data Received")

                if let rawString = String(data: data, encoding: .utf8) {
                    print("🟢 RAW RESPONSE:")
                    print(rawString)
                }
                
                do {
                    
                    
                    let response = try JSONDecoder().decode(WebViewTokenResponse.self, from: data)
                    
                    if response.status == 1,
                       let token = response.data?.token {
                        completion(.success(token))
                    } else {
                        completion(.failure(AuthError.apiError(response.message)))
                    }
                    
                } catch {
                    completion(.failure(AuthError.decodingFailed))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    // MARK: - Update FCM Token

    func updateFCMToken(
        fcmToken: String,
        userId: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {

        let parameters: [[String: Any]] = [
            ["key": "token", "value": fcmToken, "type": "text"],
            ["key": "userId", "value": userId, "type": "text"]
        ]

        APIManager.shared.postMultipartRequest(
            urlString: APIConstants.Device.updateFCMToken,
            parameters: parameters,
            requiresAuth: true
        ) { result in

            switch result {

            case .success(let data):

                print("RAW RESPONSE:")
    
                print(String(data: data, encoding: .utf8) ?? "")

                do {
                    let response = try JSONDecoder().decode(CommonResponseToken.self, from: data)

                    if response.status {
                        completion(.success(response.message))
                    } else {
                        completion(.failure(AuthError.apiError(response.message)))
                    }

                } catch {
                    completion(.failure(AuthError.decodingFailed))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}



// MARK: - Auth Error

enum AuthError: LocalizedError {
    
    case apiError(String)
    case invalidResponse
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .apiError(let message):
            return message
        case .invalidResponse:
            return "Invalid server response."
        case .decodingFailed:
            return "Failed to decode server response."
        }
    }
}



  


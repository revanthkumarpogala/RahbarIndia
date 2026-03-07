//
//  Models.swift
//  Rahbar India
//
//  Created by revanth kumar on 03/03/26.
//

import Foundation


struct APIConstants {
    static let baseURL = "https://rahbarindia.in/api"
    
    struct Auth {
        static let login = "\(baseURL)/auth/login"
        static let register = "\(baseURL)/auth/register"
        static let logout = "\(baseURL)/auth/logout"
        static let delete = "\(baseURL)/auth/delete-account"
        static let forgotPassword = "\(baseURL)/auth/forgot-password"
        static let resetPassword = "\(baseURL)/auth/reset-password"
        static let appleLogin = "\(baseURL)/auth/apple"
        static let webviewToken = "\(baseURL)/auth/webview-token"
    }
    
    struct Device {
           static let updateFCMToken = "\(baseURL)/token"
       }
}

struct RegisterResponse: Codable {
    let status: Int
    let message: String
    let token: String?
    let user: User?
}

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let mobile: String
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, mobile
        case profileImage = "profile_image"
    }
}

struct LoginResponse: Codable {
    let status: Int
    let message: String
    let token: String?
    let user: User?
}

struct AppleLoginResponse: Codable {
    let status: Int
    let message: String
    let token: String?
    let user: User?
}

struct CommonResponseToken: Decodable {
    let status: Bool
    let message: String
}

struct CommonResponse: Decodable {
    let status: Int
    let message: String
}

struct WebViewTokenResponse: Decodable {
    let status: Int
    let message: String
    let data: TokenDetails?
}

struct TokenDetails: Decodable {
    let token: String
    let expires_at: String
    let webview_url: String
}

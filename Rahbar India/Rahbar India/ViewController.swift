//
//  ViewController.swift
//  Rahbar India
//
//  Created by revanth kumar on 03/03/26.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    func openWebView() {
        AuthService.shared.fetchWebViewToken { result in
            
            switch result {
            case .success(let token):
                DispatchQueue.main.async {
                    let vc = WebViewController()
                    vc.token = token
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAccount() {
        AuthService.shared.deleteAccount { result in
            
            switch result {
            case .success(let message):
                print("Account Deleted:", message)
                // Navigate to Login Screen
                
            case .failure(let error):
                print("Delete Failed:", error.localizedDescription)
            }
        }
    }
    
    func logout() {
        AuthService.shared.logout { result in
            switch result {
            case .success(let message):
                print("Logout Success:", message)
                
                // Navigate to Login Screen
                
            case .failure(let error):
                print("Logout Failed:", error.localizedDescription)
            }
        }
    }
    
    func resetPassword(email: String, password: String, token: String) {
        AuthService.shared.resetPassword(
            email: email,
            token: token,
            password: password,
            passwordConfirmation: password
        ) { result in
            
            switch result {
            case .success(let message):
                print("Reset Successful:", message)
                
            case .failure(let error):
                print("Reset Failed:", error.localizedDescription)
            }
        }
    }
    
    
    func forgotPasswor(email: String) {
        AuthService.shared.forgotPassword(email: email) { result in
            
            switch result {
            case .success(let message):
                print("Success:", message)
                
            case .failure(let error):
                print("Error:", error.localizedDescription)
            }
        }
    }
    // update fcm
    
    func updateFCMToken(token: String, userId: String) {
        AuthService.shared.updateFCMToken(
            fcmToken: token,
            userId: userId
        ) { result in
            
            switch result {
            case .success(let message):
                print("FCM Updated:", message)
                
            case .failure(let error):
                print("Failed:", error.localizedDescription)
            }
        }
        
    }
// login api
    func callLoginAPI(email: String, password: String) {
        AuthService.shared.loginUser(email: email, password: password) { result in
            switch result {
            case .success(let message):
                print("Login Success:", message)
                // Navigate to Home Screen
                
            case .failure(let error):
                print("Login Failed:", error.localizedDescription)
            }
        }
    }

    func callAppleLogin(appleID: String,
                        email: String,
                        name: String,
                        identityToken: String) {
        
        AuthService.shared.loginWithApple(appleID: appleID,
                       email: email,
                       name: name,
                       identityToken: identityToken) { result in
            
            switch result {
            case .success(let message):
                print("Apple Login Success:", message)
                // Navigate to Home
                
            case .failure(let error):
                print("Apple Login Failed:", error.localizedDescription)
            }
        }
    }

    func callRegisterAPI(name: String,
                         mobile: String,
                         email: String,
                         password: String) {
        
        AuthService.shared.registerUser(name: name,
                     mobile: mobile,
                     email: email,
                     password: password) { result in
            
            switch result {
            case .success(let message):
                print("Registration Success:", message)
                // Navigate to Home
                
            case .failure(let error):
                print("Registration Failed:", error.localizedDescription)
            }
        }
    }

}

//
//  ViewController.swift
//  Rahbar India
//
//  Created by revanth kumar on 03/03/26.
//

import UIKit

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        // 1. Set the specific red color for "Rahbhar India"
        let fullText = "Welcome\nto Rahbhar India"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Find the range of "Rahbhar India" to color it red
        let range = (fullText as NSString).range(of: "Rahbhar India")
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0), range: range)
        
        welcomeLabel.attributedText = attributedString
        
        // 2. Setup Apple Button Border
        appleButton.layer.borderWidth = 1
        appleButton.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        appleButton.layer.cornerRadius = 12
    }

    // MARK: - Actions
    
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Please fill in all fields")
            return
        }
        print("Logging in with: \(email)")
    }
    
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
        print("Forgot password clicked")
    }
    
    @IBAction func signupTapped(_ sender: UIButton) {
        print("Navigate to signup")
    }
    
    @IBAction func appleLoginTapped(_ sender: UIButton) {
        print("Continue with Apple clicked")
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

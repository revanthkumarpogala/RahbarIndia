//
//  ViewController.swift
//  Rahbar India
//
//  Created by revanth kumar on 03/03/26.
//

import UIKit

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var passToggleBtn: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var forgotPassBtn: UIButton!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var header: UILabel!
    // MARK: - Outlets
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    
    var emailValidated = false
    var passwordValidated = false
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func onsignUpTapped(_ sender: Any) {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func forgotPassBtnTapped(_ sender: Any) {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "ForgotViewController") as? ForgotViewController)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func setupUI() {
        
        cardView.layer.cornerRadius = 15
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowRadius = 10
        
        Utilities().setMulishBold(label: header, size: 20)
        header.text = "Login"
        header.textColor = UIColor.hexStringToUIColor(hex: "000000")
        
        Utilities().setJakrtaSansMedium(label: emailLabel, size: 12)
        let emailFullText = "Email  *"
        let emailattributedString = NSMutableAttributedString(string: emailFullText)
        let emailrange = (emailFullText as NSString).range(of: "*")
        emailattributedString.addAttribute(.foregroundColor,
                                      value: UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0),
                                      range: emailrange)
        emailLabel.attributedText = emailattributedString
        
        
        Utilities().setJakrtaSansMedium(label: passwordLabel, size: 12)
        let passwordFullText = "Password  *"
        let passwordattributedString = NSMutableAttributedString(string: passwordFullText)
        let passwordrange = (passwordFullText as NSString).range(of: "*")
        passwordattributedString.addAttribute(.foregroundColor,
                                      value: UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0),
                                      range: passwordrange)
        passwordLabel.attributedText = passwordattributedString
        
        
        // 1. Set the specific red color for "Rahbhar India"
        let fullText = "Welcome\nto Rahbhar India"
        let attributedString = NSMutableAttributedString(string: fullText)

        // Set Inter-Bold font size 20 for entire text
        let font = UIFont(name: "Inter-Bold", size: 20)!
        attributedString.addAttribute(.font, value: font, range: NSRange(location: 0, length: fullText.count))

        // Find the range of "Rahbhar India" to color it red
        let range = (fullText as NSString).range(of: "Rahbhar India")
        attributedString.addAttribute(.foregroundColor,
                                      value: UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0),
                                      range: range)

        welcomeLabel.attributedText = attributedString
        
        

        emailTextField.applyTextFieldDefaulyStyle(placeHoldertext: "Email")
        passwordTextField.applyTextFieldDefaulyStyle(placeHoldertext: "Password")
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
        // 2. Setup Apple Button Border
        appleButton.layer.borderWidth = 1
        appleButton.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        appleButton.layer.cornerRadius = 12
        
        loginButton.isEnabled = false
        loginButton.alpha = 0.5
        
        emailTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        Utilities().setInterSemiBold(label: signUpLabel, size: 14)
        signUpLabel.text = "Don’t have an account?"
        signUpLabel.textColor = UIColor.hexStringToUIColor(hex: "000000")
        
        
        Utilities().setInterRegular(label: orLabel, size: 12)
        orLabel.text = "Or"
        orLabel.textColor = UIColor.hexStringToUIColor(hex: "6C7278")
        
        forgotPassBtn.setButtonDefaults(
            title: "Forgot Password?",
            fontName: "Inter-SemiBold",
            fontSize: 14,
            color: .black
        )

        loginButton.setButtonDefaults(title: "Login", fontName: "Inter-Medium", fontSize: 16, color: .white)
        
        appleButton.setButtonDefaults(title: "Continue with Apple", fontName: "Inter-SemiBold", fontSize: 14, color: UIColor.hexStringToUIColor(hex: "1A1C1E"))
                                      
        signUpBtn.setButtonDefaults(
            title: "Signup",
            fontName: "Inter-SemiBold",
            fontSize: 12,
            color: UIColor.hexStringToUIColor(hex: "DC3545")
        )
        
    }

    @IBAction func passwordShowToggle(_ sender: Any) {
        
        if iconClick {
                passwordTextField.isSecureTextEntry = false
            passToggleBtn.setImage(UIImage(named: "pass_show"), for: .normal)
            } else {
                passwordTextField.isSecureTextEntry = true
                passToggleBtn.setImage(UIImage(named: "pass_hide"), for: .normal)
            }
            iconClick = !iconClick
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func textFieldChanged() {
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        emailValidated = Validations().isValidEmail(email: email)
        passwordValidated = Validations().validatePassword(password)
        
        updateLoginButtonState()
    }
    
    
    func updateLoginButtonState() {
        
        if emailValidated && passwordValidated {
            loginButton.isEnabled = true
            loginButton.alpha = 1.0
        } else {
            loginButton.isEnabled = false
            loginButton.alpha = 0.5
        }
    }
    @IBAction func onBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Actions
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        callLoginAPI(email: email, password: password)
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
                UIUtilites().showAlert(title: "Error...!", message: error.localizedDescription, vc: self, okAction: UIAlertAction(title: "Okay", style: .default))
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



extension UITextField {
    func applyTextFieldDefaulyStyle(placeHoldertext: String = "") {
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.hexStringToUIColor(hex: "DEE2E6").cgColor
        layer.cornerRadius = 12
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
        
        Utilities().setTextFieldPlaceholderFontAndColor(
            color: UIColor.hexStringToUIColor(hex: "7B8086"),
            font: UIFont(name: "Inter-Medium", size: 14)!,
            textfield: self,
            placeHolderText: placeHoldertext
        )
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 0 {
            
            
            if textField == emailTextField {
                if !Validations().isValidEmail(email: emailTextField.text!) {
                    UIUtilites().showAlert(title: "Error", message: "Please enter valid email", vc: self, okAction: UIAlertAction(title: "Okay", style: .default))
                }
            } else if textField == passwordTextField {
                if !Validations().validatePassword(passwordTextField.text!) {
                    UIUtilites().showAlert(title: "Error", message: "Password should be 6-15 characters long", vc: self, okAction: UIAlertAction(title: "Okay", style: .default))
                }
            }
        }
    }
}

extension UIButton {
    
    func setButtonDefaults(title: String,
                           fontName: String = "Inter-Medium",
                           fontSize: CGFloat = 12,
                           color: UIColor = .black) {
        
        guard let font = UIFont(name: fontName, size: fontSize) else {
            print("Font not found:", fontName)
            return
        }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color
        ]
        
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        
        setAttributedTitle(attributedTitle, for: .normal)
        setAttributedTitle(attributedTitle, for: .highlighted)
        setAttributedTitle(attributedTitle, for: .selected)
        setAttributedTitle(attributedTitle, for: .disabled)
    }
}

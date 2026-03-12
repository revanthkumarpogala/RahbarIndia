//
//  RegisterViewController.swift
//  Rahbar India
//
//  Created by revanth kumar on 05/03/26.
//

import UIKit
import AuthenticationServices

class RegisterViewController: UIViewController {
    @IBOutlet weak var scrollViewwwww: UIScrollView!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var checkBTN: UIButton!
    @IBOutlet weak var passToggleBtn: UIButton!
    @IBOutlet weak var cnfPassTF: UITextField!
    @IBOutlet weak var cnfPassLabel: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var acceptLbel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var appleBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var signUpBtbn: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var alreadyLabel: UILabel!
    @IBOutlet weak var alreadyBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    
    var emailValidated = false
    var passwordValidated = false
    var mobileValidated = false
    var cnfpasswordValidated = false
    var nameValidated = false
    var checkBtnValidated = false
    var iconClick = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)

        checkBTN.setImage(UIImage(systemName: "square", withConfiguration: config), for: .normal)

        checkBTN.imageView?.contentMode = .scaleAspectFit
        checkBTN.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        checkBTN.tintColor = .black
        
        scrollViewwwww.layer.cornerRadius = 15
        scrollViewwwww.layer.shadowColor = UIColor.black.cgColor
        scrollViewwwww.layer.shadowOpacity = 0.1
        scrollViewwwww.layer.shadowOffset = CGSize(width: 0, height: 4)
        scrollViewwwww.layer.shadowRadius = 10
        
        
        contentView.layer.cornerRadius = 15
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 10
        
        Utilities().setMulishBold(label: header, size: 20)
        header.text = "Signup"
        header.textColor = UIColor.hexStringToUIColor(hex: "000000")
        
        Utilities().setJakrtaSansMedium(label: nameLabel, size: 12)
        let nameFullText = "Full name   * "
        let nameattributedString = NSMutableAttributedString(string: nameFullText)
        let namerange = (nameFullText as NSString).range(of: "*")
        nameattributedString.addAttribute(.foregroundColor,
                                      value: UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0),
                                      range: namerange)
        nameLabel.attributedText = nameattributedString
        
        Utilities().setJakrtaSansMedium(label: emailLabel, size: 12)
        let emailFullText = "Email  *"
        let emailattributedString = NSMutableAttributedString(string: emailFullText)
        let emailrange = (emailFullText as NSString).range(of: "*")
        emailattributedString.addAttribute(.foregroundColor,
                                      value: UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0),
                                      range: emailrange)
        emailLabel.attributedText = emailattributedString
        
        Utilities().setJakrtaSansMedium(label: mobileLabel, size: 12)
        let mobileFullText = "Mobile  *"
        let mobileattributedString = NSMutableAttributedString(string: mobileFullText)
        let mobilerange = (mobileFullText as NSString).range(of: "*")
        mobileattributedString.addAttribute(.foregroundColor,
                                      value: UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0),
                                      range: mobilerange)
        mobileLabel.attributedText = mobileattributedString
        
        Utilities().setJakrtaSansMedium(label: passwordLabel, size: 12)
        let passwordFullText = "Password  *"
        let passwordattributedString = NSMutableAttributedString(string: passwordFullText)
        let passwordrange = (passwordFullText as NSString).range(of: "*")
        passwordattributedString.addAttribute(.foregroundColor,
                                      value: UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0),
                                      range: passwordrange)
        passwordLabel.attributedText = passwordattributedString
        
        Utilities().setJakrtaSansMedium(label: cnfPassLabel, size: 12)
        let cnfpasswordFullText = "Confirm Password  *"
        let cnfpasswordattributedString = NSMutableAttributedString(string: cnfpasswordFullText)
        let cnfpasswordrange = (cnfpasswordFullText as NSString).range(of: "*")
        cnfpasswordattributedString.addAttribute(.foregroundColor,
                                      value: UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0),
                                      range: cnfpasswordrange)
        cnfPassLabel.attributedText = cnfpasswordattributedString
        
        // 1. Set the specific red color for "Rahbar India"
        let fullText = "Get started\nfree at Rahbar India"
        let attributedString = NSMutableAttributedString(string: fullText)

        // Set Inter-Bold font size 20 for entire text
        let font = UIFont(name: "Inter-Bold", size: 20)!
        attributedString.addAttribute(.font, value: font, range: NSRange(location: 0, length: fullText.count))

        // Find the range of "Rahbar India" to color it red
        let range = (fullText as NSString).range(of: "Rahbar India")
        attributedString.addAttribute(.foregroundColor,
                                      value: UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0),
                                      range: range)

        welcomeLabel.attributedText = attributedString
        
        
        emailTF.applyTextFieldDefaulyStyle(placeHoldertext: "Email")
        passwordTF.applyTextFieldDefaulyStyle(placeHoldertext: "Password")
        nameTF.applyTextFieldDefaulyStyle(placeHoldertext: "Full name")
        mobileTF.applyTextFieldDefaulyStyle(placeHoldertext: "Mobile")
        cnfPassTF.applyTextFieldDefaulyStyle(placeHoldertext: "Confirm Password")
        
        emailTF.delegate = self
        passwordTF.delegate = self
        mobileTF.delegate = self
        cnfPassTF.delegate = self
        nameTF.delegate = self
        
        
        appleBtn.layer.borderWidth = 1
        appleBtn.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        appleBtn.layer.cornerRadius = 12
        
        signUpBtbn.isEnabled = false
        signUpBtbn.alpha = 0.5
        
        emailTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        cnfPassTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        mobileTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        nameTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        Utilities().setInterSemiBold(label: alreadyLabel, size: 14)
        alreadyLabel.text = "Already have a Account?"
        alreadyLabel.textColor = UIColor.hexStringToUIColor(hex: "000000")
        
        Utilities().setInterSemiBold(label: acceptLbel, size: 14)
        acceptLbel.text = "I accept the"
        acceptLbel.textColor = UIColor.hexStringToUIColor(hex: "000000")
        
//
        
        Utilities().setInterRegular(label: orLabel, size: 12)
        orLabel.text = "Or"
        orLabel.textColor = UIColor.hexStringToUIColor(hex: "6C7278")
        
        
        signUpBtbn.setButtonDefaults(title: "Signup", fontName: "Inter-Medium", fontSize: 16, color: .white)
        
        appleBtn.setButtonDefaults(title: "Continue with Apple", fontName: "Inter-SemiBold", fontSize: 14, color: UIColor.hexStringToUIColor(hex: "1A1C1E"))
                                      
        acceptBtn.setButtonDefaults(
            title: "Terms & Conditions",
            fontName: "Inter-SemiBold",
            fontSize: 12,
            color: UIColor.hexStringToUIColor(hex: "DC3545")
        )
        
        alreadyBtn.setButtonDefaults(
            title: "Login",
            fontName: "Inter-SemiBold",
            fontSize: 12,
            color: UIColor.hexStringToUIColor(hex: "DC3545")
        )
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func textFieldChanged() {
        
        let email = emailTF.text ?? ""
        let password = passwordTF.text ?? ""
        let cnfPassword = cnfPassTF.text ?? ""
        let mobile = mobileTF.text ?? ""
        let name = nameTF.text ?? ""
        
        emailValidated = Validations().isValidEmail(email: email)
        passwordValidated = Validations().validatePassword(password)
        nameValidated = Validations().isNameValid(name: name)
        mobileValidated = Validations().isValidMobile(num: mobile)
        
        cnfpasswordValidated = (password == cnfPassword) && !cnfPassword.isEmpty
        
        updateLoginButtonState()
    }
    
    func updateLoginButtonState() {
        
        if emailValidated && passwordValidated && cnfpasswordValidated && mobileValidated && nameValidated && checkBtnValidated{
            signUpBtbn.isEnabled = true
            signUpBtbn.alpha = 1.0
        } else {
            signUpBtbn.isEnabled = false
            signUpBtbn.alpha = 0.5
        }
    }
    
    func openURL(strURL:String) {
        guard let url = URL(string: strURL) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func passwordShowToggle(_ sender: Any) {
        
        if iconClick {
                passwordTF.isSecureTextEntry = false
            passToggleBtn.setImage(UIImage(named: "pass_show"), for: .normal)
            } else {
                passwordTF.isSecureTextEntry = true
                passToggleBtn.setImage(UIImage(named: "pass_hide"), for: .normal)
            }
            iconClick = !iconClick
    }
    @IBAction func checkBtnTapped(_ sender: UIButton) {

        checkBtnValidated.toggle()

        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)
        let imageName = checkBtnValidated ? "checkmark.square.fill" : "square"

        sender.setImage(UIImage(systemName: imageName, withConfiguration: config), for: .normal)

        updateLoginButtonState()
    }
    @IBAction func acceptBtnTapped(_ sender: Any) {
        self.openURL(strURL: "https://rahbarindia.in/terms-conditions")
    }
    
    @IBAction func appleBtnTapped(_ sender: Any) {
        let provider = ASAuthorizationAppleIDProvider()
            let request = provider.createRequest()
            
            request.requestedScopes = [.fullName, .email]

            let authController = ASAuthorizationController(authorizationRequests: [request])
            authController.delegate = self
            authController.presentationContextProvider = self
            authController.performRequests()
    }
    
    func updateFCMToken(token: String, userId: String) {
        AuthService.shared.updateFCMToken(
            fcmToken: token,
            userId: userId
        ) { result in
            
            switch result {
            case .success(let message):
                print("FCM Updated:", message)
                self.openWebView()
            case .failure(let error):
                print("Failed:", error.localizedDescription)
            }
        }
        
    }
    
    func openWebView() {
        AuthService.shared.fetchWebViewToken { result in
            
            switch result {
            case .success(let token):
                DispatchQueue.main.async {
                    let vc: WebViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                    UserSessionManager.shared.saveWebToken(token: token)
                    vc.token = token
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func callAppleLogin(appleID: String,
                        email: String,
                        name: String,
                        identityToken: String,
                        authCode: String) {
        
        AuthService.shared.loginWithApple(appleID: appleID,
                       email: email,
                       name: name,
                                          identityToken: identityToken, authCode: authCode) { result in
            
            switch result {
            case .success(let message):
                print("Apple Login Success:", message)
                // Navigate to Home
                let fcmToken = UserDefaults.standard.string(forKey: "fcm_token") ?? ""
                let userID = "\(UserSessionManager.shared.getUser()?.id ?? 0)"
                self.updateFCMToken(token: fcmToken, userId: userID)
                
                
            case .failure(let error):
                print("Apple Login Failed:", error.localizedDescription)
                UIUtilites().showAlert(title: "Error...!", message: error.localizedDescription, vc: self, okAction: UIAlertAction(title: "Okay", style: .default))
            }
        }
    }
    
    @IBAction func alreadyBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func signUpBtnTapped(_ sender: Any) {
        let pass = passwordTF.text ?? ""
            let cnfPass = cnfPassTF.text ?? ""
            
            if pass != cnfPass {
                UIUtilites().showAlert(title: "Error", message: "Passwords do not match", vc: self, okAction: UIAlertAction(title: "Okay", style: .default))
                return
            }
        
        callRegisterAPI(name: nameTF.text ?? "", mobile: mobileTF.text ?? "", email: emailTF.text ?? "", password: passwordTF.text ?? "")
    }
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
                self.nameTF.text = ""
                self.mobileTF.text = ""
                self.emailTF.text = ""
                self.passwordTF.text = ""
                self.cnfPassTF.text = ""
            
                let fcmToken = UserDefaults.standard.string(forKey: "fcm_token") ?? ""
                let userID = "\(UserSessionManager.shared.getUser()?.id ?? 0)"
                self.updateFCMToken(token: fcmToken, userId: userID)
            case .failure(let error):
                print("Registration Failed:", error.localizedDescription)
                UIUtilites().showAlert(title: "Error...!", message: error.localizedDescription, vc: self, okAction: UIAlertAction(title: "Okay", style: .default))
            }
        }
    }
}

extension RegisterViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 0 {
            
            
            if textField == emailTF {
                if !Validations().isValidEmail(email: emailTF.text ?? "") {
                    UIUtilites().showAlert(title: "Error", message: "Please enter valid email", vc: self, okAction: UIAlertAction(title: "Okay", style: .default))
                }
            } else if textField == passwordTF {
                if !Validations().validatePassword(passwordTF.text ?? "") {
                    UIUtilites().showAlert(title: "Error", message: "Password should be 6-15 characters long", vc: self, okAction: UIAlertAction(title: "Okay", style: .default))
                }
            } else if textField == cnfPassTF {
                let pass = passwordTF.text ?? ""
                let cnfPass = cnfPassTF.text ?? ""
                
                if cnfPass != pass {
                    UIUtilites().showAlert(title: "Error",
                                           message: "Passwords do not match",
                                           vc: self,
                                           okAction: UIAlertAction(title: "Okay", style: .default))
                } else if !Validations().validatePassword(cnfPass) {
                    UIUtilites().showAlert(title: "Error",
                                           message: "Password should be 6-15 characters long",
                                           vc: self,
                                           okAction: UIAlertAction(title: "Okay", style: .default))
                }
            } else if textField == mobileTF {
                if !Validations().isValidMobile(num: mobileTF.text ?? "") {
                    UIUtilites().showAlert(title: "Error", message: "Invalid mobile number", vc: self, okAction: UIAlertAction(title: "Okay", style: .default))
                }
            } else if textField == nameTF {
                if !Validations().isNameValid(name: nameTF.text ?? "") {
                    UIUtilites().showAlert(title: "Error", message: "Name should be min 3 characters", vc: self, okAction: UIAlertAction(title: "Okay", style: .default))
                }
            }
        }
    }
}


extension RegisterViewController: ASAuthorizationControllerDelegate {

    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {

        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }

        let userId = credential.user

        if let email = credential.email {
            UserDefaults.standard.set(email, forKey: "apple_email")
        }
        if let firstName = credential.fullName?.givenName {
            UserDefaults.standard.set(firstName, forKey: "apple_first_name")
        }

        if let lastName = credential.fullName?.familyName {
            UserDefaults.standard.set(lastName, forKey: "apple_last_name")
        }
        let idToken = String(data: credential.identityToken ?? Data(), encoding: .utf8) ?? ""
        let authCode = String(data: credential.authorizationCode ?? Data(), encoding: .utf8) ?? ""

        let email = credential.email ?? UserDefaults.standard.string(forKey: "apple_email") ?? ""
        let firstName = credential.fullName?.givenName ?? UserDefaults.standard.string(forKey: "apple_first_name") ?? ""
        let lastName = credential.fullName?.familyName ?? UserDefaults.standard.string(forKey: "apple_last_name") ?? ""
        
        print("UserID:", userId)
        print("Token:", idToken)
        print("Code:", authCode)
        print("Email:", email)
        print("Name:", firstName, lastName)
        UserDefaults.standard.set(userId, forKey: "apple_user_id")

        self.callAppleLogin(
            appleID: userId,
            email: email,
            name: firstName + " " + lastName,
            identityToken: idToken,
            authCode: authCode
        )
    }

    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithError error: Error) {

        print("Apple login failed:", error.localizedDescription)
    }
}


extension RegisterViewController: ASAuthorizationControllerPresentationContextProviding {

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}

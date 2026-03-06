//
//  ForgotViewController.swift
//  Rahbar India
//
//  Created by revanth kumar on 03/03/26.
//

import UIKit

class ForgotViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var header: UILabel!
    
    var emailValidated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func forgotPasswor(email: String) {
        AuthService.shared.forgotPassword(email: email) { result in
            
            switch result {
            case .success(let message):
                print("Success:", message)
                
                UIUtilites().showAlert(title: "Success...!", message: message, vc: self, okAction: UIAlertAction(title: "Okay", style: .default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
            case .failure(let error):
                print("Error:", error.localizedDescription)
                UIUtilites().showAlert(title: "Error...!", message: error.localizedDescription, vc: self, okAction: UIAlertAction(title: "Okay", style: .default))
            }
        }
    }
    
    func setupUI() {
        
        Utilities().setMulishBold(label: header, size: 20)
        header.text = "Forgot Password"
        header.textColor = UIColor.hexStringToUIColor(hex: "000000")
        
        submitButton.setButtonDefaults(title: "Submit", fontName: "Inter-Medium", fontSize: 16, color: .white)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // Apply styling that isn't easily done in basic storyboard
        cardView.layer.cornerRadius = 15
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowRadius = 10
        
        submitButton.isEnabled = false
        submitButton.alpha = 0.5
        
        
        let fullText = "Hey there!\nWelcome to Rahbhar India"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Find the range of "Rahbhar India" to color it red
        let font = UIFont(name: "Inter-Bold", size: 20)!
        attributedString.addAttribute(.font, value: font, range: NSRange(location: 0, length: fullText.count))
        let range = (fullText as NSString).range(of: "Rahbhar India")
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0), range: range)
        
        welcomeLabel.attributedText = attributedString
        
        
        Utilities().setJakrtaSansMedium(label: emailLabel, size: 12)
        let emailFullText = "Email  *"
        let emailattributedString = NSMutableAttributedString(string: emailFullText)
        let emailrange = (emailFullText as NSString).range(of: "*")
        emailattributedString.addAttribute(.foregroundColor,
                                      value: UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0),
                                      range: emailrange)
        emailLabel.attributedText = emailattributedString
        
        emailTextField.applyTextFieldDefaulyStyle(placeHoldertext: "Email")
        emailTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
    }
    
    @objc func textFieldChanged() {
        
        let email = emailTextField.text ?? ""
        
        emailValidated = Validations().isValidEmail(email: email)
        updateLoginButtonState()
    }
    
    func updateLoginButtonState() {
        
        if emailValidated {
            submitButton.isEnabled = true
            submitButton.alpha = 1.0
        } else {
            submitButton.isEnabled = false
            submitButton.alpha = 0.5
        }
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            print("Please enter an email")
            return
        }
        forgotPasswor(email: email)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension ForgotViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 0 {
            
            if textField == emailTextField {
                if !Validations().isValidEmail(email: emailTextField.text!) {
                    UIUtilites().showAlert(title: "Error", message: "Please enter valid email", vc: self, okAction: UIAlertAction(title: "Okay", style: .default))
                }
            }
        }
    }
}

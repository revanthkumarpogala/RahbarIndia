//
//  ForgotViewController.swift
//  Rahbar India
//
//  Created by revanth kumar on 03/03/26.
//

import UIKit

class ForgotViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        // Apply styling that isn't easily done in basic storyboard
        cardView.layer.cornerRadius = 15
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowRadius = 10
        
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        emailTextField.layer.cornerRadius = 8
        
        // Add padding to the left of the text field so text doesn't touch the edge
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 45))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always
        
        let fullText = "Hey there!\nWelcome to Rahbhar India"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Find the range of "Rahbhar India" to color it red
        let range = (fullText as NSString).range(of: "Rahbhar India")
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0), range: range)
        
        welcomeLabel.attributedText = attributedString
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            print("Please enter an email")
            return
        }
        
        // Add your API logic here
        print("Reset link requested for: \(email)")
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

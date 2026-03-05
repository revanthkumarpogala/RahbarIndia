//
//  FontUtilites.swift
//  Rahbar India
//
//  Created by revanth kumar on 05/03/26.
//

import Foundation
import UIKit

class Utilities {
    
    let textColor = UIColor.hexStringToUIColor(hex: "#000000")
   
    func setMulishBold(label : UILabel, size: CGFloat) {
        label.font = UIFont(name: "Mulish-Bold", size: size)
        label.textColor = textColor
    }
    
    func setJakrtaSansRegular(label : UILabel, size: CGFloat) {
        label.font = UIFont(name: "PlusJakartaSans-Regular", size: size)
        label.textColor = textColor
    }
    
    func setJakrtaSansBold(label : UILabel, size: CGFloat) {
        label.font = UIFont(name: "PlusJakartaSans-Bold", size: size)
        label.textColor = textColor
    }
    
    func setJakrtaSansLight(label : UILabel, size: CGFloat) {
        label.font = UIFont(name: "PlusJakartaSans-Light", size: size)
        label.textColor = textColor
    }
    func setJakrtaSansMedium(label : UILabel, size: CGFloat) {
        label.font = UIFont(name: "PlusJakartaSans-Medium", size: size)
        label.textColor = textColor
    }
    
    func setJakrtaSansSemiBold(label : UILabel, size: CGFloat) {
        label.font = UIFont(name: "PlusJakartaSans-SemiBold", size: size)
        label.textColor = textColor
    }
    func setInterSemiBold(label : UILabel, size: CGFloat) {
        label.font = UIFont(name: "Inter-SemiBold", size: size)
        label.textColor = textColor
    }
    func setInterRegular(label : UILabel, size: CGFloat) {
        label.font = UIFont(name: "Inter-Regular", size: size)
        label.textColor = textColor
    }
    func setInterBold(label : UILabel, size: CGFloat) {
        label.font = UIFont(name: "Inter-Bold", size: size)
        label.textColor = textColor
    }
    func setInterLight(label : UILabel, size: CGFloat) {
        label.font = UIFont(name: "Inter-Light-BETA", size: size)
        label.textColor = textColor
    }
    func setInterMedium(label : UILabel, size: CGFloat) {
        label.font = UIFont(name: "Inter-Medium", size: size)
        label.textColor = textColor
    }
    func setTextFieldPlaceholderFontAndColor(color: UIColor, font:UIFont, textfield:UITextField, placeHolderText: String) {
        let attributes = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font : font
        ]

        textfield.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes:attributes)
    }
}


extension UIColor {
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    func mainColorPurple() -> UIColor {
        UIColor.hexStringToUIColor(hex: "#490DA7")
    }
    
    func headerTextColr() -> UIColor {
        UIColor.hexStringToUIColor(hex: "#0B011C")
    }
    
    func descTextColor() -> UIColor {
        UIColor.hexStringToUIColor(hex: "#3B3544")
    }
    
    func viewBorderColor() -> UIColor {
        UIColor.hexStringToUIColor(hex: "#F2F2F2")
    }
    
}


class Validations {
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        //        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        //        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        //        return passwordPredicate.evaluate(with: password)
        password.count > 7
    }
    func isNameValid(name: String) -> Bool {
        name.count > 2
    }
    
}


class UIUtilites {
    func showAlert(title: String, message:String, vc: UIViewController, okAction: UIAlertAction, cancelAction: UIAlertAction? = nil, thirdAction: UIAlertAction? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           // Add the actions
           alertController.addAction(okAction)
        if let cAvtion = cancelAction {
            alertController.addAction(cAvtion)
        }
        if let third = thirdAction {
            alertController.addAction(third)
        }
           // Present the controller
        vc.present(alertController, animated: true, completion: nil)
    }
    
}

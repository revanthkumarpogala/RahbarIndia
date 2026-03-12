//
//  SettingsViewController.swift
//  Rahbar India
//
//  Created by revanth kumar on 06/03/26.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var mainDsec: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var detailsTV: UITableView!
    @IBOutlet weak var mainHedaer: UILabel!
    @IBOutlet weak var profileIV: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = UserSessionManager.shared.getUser()
        let name = user?.name
        let email = user?.email
        
        // Do any additional setup after loading the view.
        
        self.detailsTV.register(UINib(nibName: "SettingsFirstCell", bundle: nil),
                                forCellReuseIdentifier: "SettingsFirstCell")
        
        self.detailsTV.register(UINib(nibName: "SettingsSecondCell", bundle: nil),
                                forCellReuseIdentifier: "SettingsSecondCell")
        
        self.detailsTV.separatorStyle = .none
        detailsTV.rowHeight = UITableView.automaticDimension
        detailsTV.estimatedRowHeight = 120
        
        Utilities().setMulishRegular(label: mainHedaer, size: 15)
        mainDsec.text = name
        mainHedaer.textColor = UIColor.black
        
        Utilities().setMulishRegular(label: mainDsec, size: 15)
        mainHedaer.text = email
        mainDsec.textColor = UIColor.black
        
        Utilities().setMulishSemiBold(label: bottomLabel, size: 14)
        bottomLabel.textColor = .white
        bottomLabel.text = "Copyright @RahbarIndia All Rights Reserved"
        
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 7
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0  && indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "SettingsFirstCell",
                for: indexPath
            ) as! SettingsFirstCell
            cell.selectionStyle = .none
            cell.setHedar(title: "My Profile")
            return cell
        } else if indexPath.section == 0  && indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "SettingsFirstCell",
                for: indexPath
            ) as! SettingsFirstCell
            cell.selectionStyle = .none
            cell.setHedar(title: "About us")
            return cell
        } else  if indexPath.section == 0  && indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "SettingsFirstCell",
                for: indexPath
            ) as! SettingsFirstCell
            cell.selectionStyle = .none
            cell.setHedar(title: "Privacy Policy")
            return cell
        } else if indexPath.section == 0  && indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "SettingsFirstCell",
                for: indexPath
            ) as! SettingsFirstCell
            cell.selectionStyle = .none
            cell.setHedar(title: "Refund Policy")
            return cell
        }else if indexPath.section == 0  && indexPath.row == 4{
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "SettingsFirstCell",
                for: indexPath
            ) as! SettingsFirstCell
            cell.selectionStyle = .none
            cell.setHedar(title: "Terms & Conditions")
            return cell
        }else if indexPath.section == 0  && indexPath.row == 5{
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "SettingsFirstCell",
                for: indexPath
            ) as! SettingsFirstCell
            cell.selectionStyle = .none
            cell.setHedar(title: "Logout")
            return cell
        }else if indexPath.section == 0  && indexPath.row == 6{
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "SettingsFirstCell",
                for: indexPath
            ) as! SettingsFirstCell
            cell.selectionStyle = .none
            cell.setHedar(title: "Delete Account")
            return cell
        
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "SettingsSecondCell",
                for: indexPath
            ) as! SettingsSecondCell
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var linkToOpen = ""
        if indexPath.row == 0  && indexPath.section == 0{
            linkToOpen = "https://rahbarindia.in/profile"
        } else if indexPath.row == 1 && indexPath.section == 0{
            linkToOpen = "https://rahbarindia.in/about-us"
        } else if indexPath.row == 2 && indexPath.section == 0{
            linkToOpen = "https://rahbarindia.in/privacy-policy"
        } else if indexPath.row == 3 && indexPath.section == 0{
            linkToOpen = "https://rahbarindia.in/refund-policy"
        } else if indexPath.row == 4 && indexPath.section == 0{
            linkToOpen = "https://rahbarindia.in/terms-conditions"
        } else if indexPath.row == 5 && indexPath.section == 0{
            // logout
            logout()
        } else if indexPath.row == 6 && indexPath.section == 0{
            // delete account
            deleteAccountWithPopup()
        }
        
        self.openURL(strURL: linkToOpen)
    }
        
    func openURL(strURL:String) {
        guard let url = URL(string: strURL) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func logout() {
        AuthService.shared.logout { result in
            switch result {
            case .success(let message):
                print("Logout Success:", message)
                
                UserSessionManager.shared.clearSession()
                // Navigate to Login Screen
                // Load Login Navigation
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginNav = storyboard.instantiateViewController(withIdentifier: "lognav") as! UINavigationController
                
                // Get SceneDelegate
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    sceneDelegate.window?.rootViewController = loginNav
                    sceneDelegate.window?.makeKeyAndVisible()
                }
                
            case .failure(let error):
                print("Logout Failed:", error.localizedDescription)
                UIUtilites().showAlert(title: "Error...!", message: "Unable to logout. Please try again.", vc: self, okAction: UIAlertAction(title: "Okay", style: .default))
            }
        }
    }
    func deleteAccountWithPopup() {
        let title = "Delete Account"
        let message = "Are you sure you want to delete your account? This will permanently erase your account."
        
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteAccount()
        })
        
        UIUtilites().showAlert(title: title, message: message, vc: self, okAction: cancel, cancelAction: delete)
    }
    func deleteAccount() {
        AuthService.shared.deleteAccount { result in
            
            switch result {
            case .success(let message):
                print("Account Deleted:", message)
                // Navigate to Login Screen
                self.navigationController?.popToRootViewController(animated: true)
                
            case .failure(let error):
                print("Delete Failed:", error.localizedDescription)
                UIUtilites().showAlert(title: "Error...!", message: "Unable to delete account. Please try again.", vc: self, okAction: UIAlertAction(title: "Okay", style: .default))
            }
        }
    }
    
    }

extension SettingsViewController: SettingsSecondCellDelegate {
    func didSelectCell(index: Int) {
        print(index)
        
        let xLink = "https://x.com/IndianRahbar"
        let linkedINLink = "https://www.linkedin.com/in/rahbar-indian-4b28543b6?utm_source=share_via&utm_content=profile&utm_medium=member_android"
        let fbLink = "https://www.facebook.com/profile.php?id=61583771440277"
        let instaLink = "https://www.instagram.com/rahbarindia"
        
        if index == 0 {
            self.openURL(strURL: fbLink)
        } else if index == 1 {
            self.openURL(strURL: instaLink)
        } else if index == 2 {
            self.openURL(strURL: linkedINLink)
        } else {
            self.openURL(strURL: xLink)
        }
    }
}

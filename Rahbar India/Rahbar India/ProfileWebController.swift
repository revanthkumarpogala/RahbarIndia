//
//  ProfileWebController.swift
//  Rahbar India
//
//  Created by revanth kumar on 12/03/26.
//

import UIKit
import WebKit

class ProfileWebController: UIViewController {
    var token: String?
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.navigationDelegate = self

        token = UserSessionManager.shared.getWebToken()
        loadWebPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    private func loadWebPage() {
        guard let token = token else { return }

        let encodedToken = token.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? token
        let urlString = "https://rahbarindia.in/profile"

        guard let url = URL(string: urlString) else { return }

        webView.load(URLRequest(url: url))
    }
    
}

extension ProfileWebController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        LoaderView.shared.show()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        LoaderView.shared.hide()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        LoaderView.shared.hide()
        print(error.localizedDescription)
    }
}

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var token: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = UserSessionManager.shared.getToken()
        webView.navigationDelegate = self
        loadWebPage()
    }

    @IBAction func onSettingsTapped(_ sender: Any) {
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController)!
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func loadWebPage() {
        guard let token = token else { return }

        let encodedToken = token.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? token
        let urlString = "https://rahbarindia.in/webview-login?token=\(encodedToken)"

        guard let url = URL(string: urlString) else { return }

        webView.load(URLRequest(url: url))
    }
}

extension WebViewController: WKNavigationDelegate {

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

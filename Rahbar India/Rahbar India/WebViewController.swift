import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var token: String?
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadWebPage()
    }
    
    private func setupWebView() {
//        webView = WKWebView(frame: view.bounds)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        view.addSubview(webView)
    }
    
    private func loadWebPage() {
        guard let token = token else { return }
        
        let baseURL = "https://rahbarindia.in"
        let urlString = "\(baseURL)/webview-login?token=\(token)"
        
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

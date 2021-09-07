//
//  MainViewController.swift
//  JOYTT
//
//  Created by apple on 2021/8/18.
//

import UIKit
import WebKit

class MainViewController: UIViewController {
    var url: String?
    var mWebView: WKWebView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url {
            loadURL(urlString: url)
        }
    }
    
    private func loadURL(urlString: String) {
        let url = URL(string: urlString)
                if let url = url {
//                    let request = URLRequest(url: url)
                    // init and load request in webview.
                    mWebView = WKWebView(frame: self.view.frame)
                    if let mWebView = mWebView {
                        mWebView.navigationDelegate = self
//                        mWebView.load(request)
                        
                        loadWebPage(url: url)
                        self.view.addSubview(mWebView)
                        self.view.sendSubviewToBack(mWebView)
                    }
                }
    }
    
    func loadWebPage(url: URL)  {
            var customRequest = URLRequest(url: url)
        customRequest.setValue(TokenManager.shared.get(key: .loginToken), forHTTPHeaderField: "token")
            mWebView!.load(customRequest)
        }

}

extension MainViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        loginFailed()
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping
        (WKNavigationActionPolicy) -> Void) {
            if navigationAction.request.httpMethod != "GET" || navigationAction.request.value(forHTTPHeaderField: "token") != nil {
                // not a GET or already a custom request - continue
                decisionHandler(.allow)
                return
            }
            decisionHandler(.cancel)
            loadWebPage(url: navigationAction.request.url!)
        }
}

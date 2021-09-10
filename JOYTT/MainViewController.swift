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
                    let request = URLRequest(url: url)
                    // init and load request in webview.
                    mWebView = WKWebView(frame: self.view.frame)
                    if let mWebView = mWebView {
                        mWebView.navigationDelegate = self
                        
                        guard let cookie = HTTPCookie(properties: [
                               .domain: URLs.domain.rawValue,
                               .path: URLs.path.rawValue,
                               .name: "token",
                               .value: TokenManager.shared.get(key: .loginToken) ?? "",
                               .secure: "true",
                            .expires: NSDate(timeIntervalSinceNow: 86400)
                           ]) else { return }

                        mWebView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie) {
                            mWebView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
                                   print("cookis: \(cookies)")
                               }
                           }
                        mWebView.load(request)
                        self.view.addSubview(mWebView)
                        self.view.sendSubviewToBack(mWebView)
                    }
                }
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
}

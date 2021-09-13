//
//  GlobalFunc.swift
//  JOYTT
//
//  Created by apple on 2021/8/18.
//

import UIKit

enum URLs: String {
    case mainUrl = "1"
    case findStoreIdUrl = "2"
    case forgotPasswordUrl = "3"
    case domain = "4"
    case path = "5"
    case baseUrl = "6"
}

func loginSuccess(_ token: String) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    if let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
        mainVC.url = URLs.mainUrl.rawValue
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        keyWindow?.rootViewController = mainVC
    }
}

func loginFailed() {
    let storyboard = UIStoryboard(name: "Login", bundle: nil)
    if let LoginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        keyWindow?.rootViewController = LoginVC
    }
}

//
//  GlobalFunc.swift
//  JOYTT
//
//  Created by apple on 2021/8/18.
//

import UIKit

let mainUrl = "https://www.google.com.tw"
let findStoreIDUrl = "https://github.com/OrtizLin"
let forgotPasswordUrl = "https://medium.com/"

func loginSuccess(_ token: String) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    if let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
        mainVC.url = mainUrl
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

//
//  LoginViewController.swift
//  JOYTT
//
//  Created by apple on 2021/8/18.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var keepLoginButton: UISwitch!
    @IBOutlet weak var storeIDTextField: UITextField!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func findStoreIDButtonPressed(_ sender: Any) {
        loginSuccess(URLs.findStoreIdUrl.rawValue)
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        loginSuccess(URLs.forgotPasswordUrl.rawValue)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
       
        if !inputCheck() { return }
        
//        NetworkClient.login(storeCode: storeIDTextField.text!, account: accountTextField.text!, password: passwordTextField.text!, deviceToken: "fakePushToken", onSuccess: { (loginData) in
//
//            guard let token = loginData.token else { return }
//            self.keepLoginStatus(self.keepLoginButton.isOn, token: token)
//            loginSuccess(token)
//
//        }) { (error) in
//            self.showAlert(error)
//        }
        
        login(storeIDTextField.text!, accountTextField.text!, passwordTextField.text!, TokenManager.shared.get(key: .pushToken) ?? "noToken") { (result, value) in
            if result {
                DispatchQueue.main.async {
                    self.keepLoginStatus(self.keepLoginButton.isOn, token: value)
                    loginSuccess(URLs.mainUrl.rawValue)
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(value)
                }
            }
        }
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

extension LoginViewController {
    
    func keepLoginStatus(_ keep: Bool, token: String) {
        if keep {
            TokenManager.shared.set(key: .loginToken, token: token)
            TokenManager.shared.set(key: .storeID, token: storeIDTextField.text!)
            TokenManager.shared.set(key: .account, token: accountTextField.text!)
            TokenManager.shared.set(key: .password, token: passwordTextField.text!)
        } else {
            TokenManager.shared.reset(key: .loginToken)
            TokenManager.shared.reset(key: .storeID)
            TokenManager.shared.reset(key: .account)
            TokenManager.shared.reset(key: .password)
        }
    }
    
    func inputCheck() -> Bool {
        var alertMessage = ""
        
        if storeIDTextField.text == "" {
            alertMessage = "請輸入店家ID"
        } else if accountTextField.text == "" {
            alertMessage = "請輸入帳號"
        } else if passwordTextField.text == "" {
            alertMessage = "請輸入密碼"
        }
        
        if alertMessage == "" {
            return true
        } else {
            showAlert(alertMessage)
            return false
        }
    }
    
    func showAlert(_ msg: String = "請重新輸入") {
        // 建立一個提示框
        let alertController = UIAlertController(title: "錯誤", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

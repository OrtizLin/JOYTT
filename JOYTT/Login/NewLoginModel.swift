//
//  NewLoginModel.swift
//  JOYTT
//
//  Created by apple on 2021/9/1.
//

import Foundation

let apiURL = ""

func login( _ store_code: String, _ account: String, _ password: String, _ device_token: String, callback: @escaping (Bool, String) -> Void) {
    
    guard let url = URL(string: "\(apiURL)/login") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.timeoutInterval = 30
    let json: [String: Any] = ["store_code": store_code,
                               "account": account,
                               "password": password,
                               "device_token": device_token,
                               "platform": 1]
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    request.httpBody = jsonData
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if error != nil { callback(false, "") }
        guard let data = data else { return }
        do {
            let decoder = JSONDecoder()
            let loginData = try decoder.decode(NewLoginData.self, from: data)
            if let result = loginData.loginResult,
               let code = loginData.code, code == 1 {
                callback(true, result.token ?? "")
            } else {
                callback(false, loginData.msg ?? "")
            }
        } catch {
            callback(false, "伺服器解析錯誤")
        }
    }
    task.resume()
    
}

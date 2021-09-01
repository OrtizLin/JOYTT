//
//  LoginData.swift
//  JOYTT
//
//  Created by apple on 2021/8/18.
//

import Foundation

struct LoginData : Codable {
    let token : String?
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
    
}

struct NewLoginData: Codable {
    let code: Int?
    let loginResult: LoginResult?
    let msg: String?
    
    private enum CodingKeys: String, CodingKey {
        case code = "code"
        case loginResult = "return"
        case msg = "msg"
    }
}

struct LoginResult: Codable {
    let token: String?
    
    private enum CodingKeys: String, CodingKey {
        case token = "token"
    }
}

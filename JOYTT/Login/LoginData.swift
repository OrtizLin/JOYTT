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

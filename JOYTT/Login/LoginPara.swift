//
//  LoginPara.swift
//  JOYTT
//
//  Created by apple on 2021/8/18.
//

import Foundation

struct LoginPara: Encodable {
    var storeID: Parameter<String>
    var account: Parameter<String>
    var password: Parameter<String>
    
    enum CodingKeys: String, CodingKey {
        case storeID = "storeID"
        case account = "account"
        case password = "password"
    }
}

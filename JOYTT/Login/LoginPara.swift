//
//  LoginPara.swift
//  JOYTT
//
//  Created by apple on 2021/8/18.
//

import Foundation

struct LoginPara: Encodable {
    var store_code: Parameter<String>
    var account: Parameter<String>
    var password: Parameter<String>
    var device_token: Parameter<String>
    var platform: Parameter<Int>

    enum CodingKeys: String, CodingKey {
        case store_code = "store_code"
        case account = "account"
        case password = "password"
        case device_token = "device_token"
        case platform = "platform"
    }
}


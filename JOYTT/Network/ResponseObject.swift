//
//  ResponseObject.swift
//  JOYTT
//
//  Created by apple on 2021/8/18.
//

import Foundation

class ResponseObject<T: Decodable>: Decodable {
    var code: Int?
    var msg: String?
    var result: T?
    var error: Empty?
    var validate: Empty?
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case result = "return"
        case error = "error"
        case validate = "validate"
    }
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            code = try values.decodeIfPresent(Int.self, forKey: .code)
            msg = try values.decodeIfPresent(String.self, forKey: .msg)
            result = try values.decodeIfPresent(T.self, forKey: .result)
            error = try values.decodeIfPresent(Empty.self, forKey: .error)
            validate = try values.decodeIfPresent(Empty.self, forKey: .error)
        }
}

class Empty: Decodable {
}


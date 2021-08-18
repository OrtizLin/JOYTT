//
//  ResponseObject.swift
//  JOYTT
//
//  Created by apple on 2021/8/18.
//

import Foundation

class ResponseObject<T: Decodable>: Decodable {
    var code: ResponseCode?
    var msg: String?
    var result: T?
    var error: ErrorResult?
    
    enum CodingKeys: String, CodingKey {
        case code
        case msg
        case result = "return"
        case error
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(ResponseCode.self, forKey: .code)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        result = try values.decodeIfPresent(T.self, forKey: .result)
        error = try values.decodeIfPresent(ErrorResult.self, forKey: .error)
    }
}

class Empty: Decodable {
}

enum ResponseCode: Int, Decodable {
    case success = 0
    case fail = -1
}

struct ErrorResult: Codable {
    let code: String?
    let unit: String?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case unit = "unit"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        unit = try values.decodeIfPresent(String.self, forKey: .unit)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

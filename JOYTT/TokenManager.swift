//
//  TokenManager.swift
//  JOYTT
//
//  Created by apple on 2021/8/18.
//

import Foundation
import KeychainAccess

enum AccessKey: String {
    // Push Token
    case pushToken = "pushToken"
    // Server Token
    case loginToken = "loginToken"
    case storeID = "storeID"
    case account = "account"
    case password = "password"
    case expiredTS = "expiredTS"
}

protocol TokenManageable {
    func set(key: AccessKey, token: String)
    func get(key: AccessKey) -> String?
    func reset(key: AccessKey)
}

class TokenManager: TokenManageable {
    static let shared = TokenManager()
    private let keychain = Keychain()
    
    private init() {
    }
    
    func set(key: AccessKey, token: String) { keychain[key.rawValue] = token }
    func get(key: AccessKey) -> String? { return keychain[key.rawValue] }
    func reset(key: AccessKey) { keychain[key.rawValue] = nil }
}

//
//  NetworkClient.swift
//  JOYTT
//
//  Created by apple on 2021/8/18.
//

import Foundation
import Siesta

internal let NetworkClient = _NetworkClient.shared

internal class _NetworkClient {
    static let shared = _NetworkClient()
    var service = Service(baseURL: baseURL, standardTransformers: [.text, .image])
    let jsonDecoder = JSONDecoder()
    
    fileprivate init() {
        configureLoginAPI()
    }
}

extension NSNull: JSONConvertible { }

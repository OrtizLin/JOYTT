//
//  RequestObject.swift
//  JOYTT
//
//  Created by apple on 2021/8/18.
//

import Foundation
import UIKit

struct RequestObject<T: Encodable>: Encodable {
    var attributes: Attributes
    var params: T
    
    init(params: T) {
        attributes = Attributes.shared
        self.params = params
    }
}

struct Attributes: Encodable {
    static let shared = Attributes()
    
    var id: String?
    var osVer: String?
    var deviceModel: String?
    var deviceType: String?
    var appVer: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case osVer = "OSVer"
        case deviceModel = "DeviceModel"
        case deviceType = "DeviceType"
        case appVer = "AppVer"
    }
    
    init() {
        let device = UIDevice()
        id = device.identifierForVendor?.uuidString
        osVer = device.systemVersion
        deviceModel = device.modelName
        deviceType = "iPhone" // device.systemName
        appVer = Bundle.main.releaseVersionNumber
    }
}


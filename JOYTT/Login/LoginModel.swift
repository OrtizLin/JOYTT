//
//  LoginModel.swift
//  JOYTT
//
//  Created by apple on 2021/8/18.
//

import Foundation
import Siesta

protocol LoginModel {
    func login(storeCode: String, account: String, password: String, deviceToken: String, onSuccess: @escaping (LoginData) -> Void, onFailure: @escaping(String) -> Void)
}

extension _NetworkClient: LoginModel {
    func configureLoginAPI() {
        service.configureTransformer("/login") {
            try self.jsonDecoder.decode(ResponseObject<LoginData>.self, from: $0.content)
        }
    }
    
    func login(storeCode: String, account: String, password: String, deviceToken: String, onSuccess: @escaping (LoginData) -> Void, onFailure: @escaping (String) -> Void) {
        let params = LoginPara(store_code: .value(storeCode), account: .value(account), password: .value(password), device_token: .value(deviceToken), platform: .value(1))
        guard let dict = try? params.asDictionary() else { return }
        service.resource("/login")
            .request(.post, json: dict)
            .onSuccess {(entity) in
                guard let json: ResponseObject<LoginData> =
                        entity.typedContent(),
                      let code = json.code, let msg = json.msg else {
                        onFailure("/login JSON 解析錯誤")
                        return
                }
                switch code {
                case 1:
                    guard let result = json.result else {
                        onFailure("/login 的 result 為 nil")
                        return
                    }
                    onSuccess(result)
                default: onFailure(msg)
                }
            }.onFailure { (error) in
                onFailure("登入失敗")
            }
    }
}

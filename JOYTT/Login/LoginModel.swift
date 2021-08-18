//
//  LoginModel.swift
//  JOYTT
//
//  Created by apple on 2021/8/18.
//

import Foundation
import Siesta

protocol LoginModel {
    func login(storeID: String, account: String, password: String, onSuccess: @escaping (LoginData) -> Void, onFailure: @escaping(String) -> Void)
}

extension _NetworkClient: LoginModel {
    func configureLoginAPI() {
        service.configureTransformer("/login") {
            try self.jsonDecoder.decode(ResponseObject<LoginData>.self, from: $0.content)
        }
    }
    
    func login(storeID: String, account: String, password: String, onSuccess: @escaping (LoginData) -> Void, onFailure: @escaping (String) -> Void) {
        let params = LoginPara(storeID: .value(storeID),
                               account: .value(account),
                               password: .value(password))
        let para = RequestObject<LoginPara>(params: params)
        guard let dict = try? para.asDictionary() else { return }
        
        service.resource("/login")
            .request(.put, json: dict)
            .onSuccess {(entity) in
                guard let json: ResponseObject<LoginData> =
                        entity.typedContent(),
                      let code = json.code, let msg = json.msg else {
                        onFailure("/password/getcode JSON 解析錯誤")
                        return
                }
                switch code {
                case .success:
                    guard let result = json.result else {
                        onFailure("/login 的 result 為 nil")
                        return
                    }
                    onSuccess(result)
                default: onFailure(msg)
                }
            }.onFailure { (error) in
                onFailure(NSLocalizedString(error.userMessage, comment: "錯誤訊息"))
            }
    }
}

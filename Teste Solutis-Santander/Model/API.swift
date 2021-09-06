//
//  API.swift
//  Teste Solutis-Santander
//
//  Created by Virtual Machine on 06/09/21.
//

import UIKit
import Alamofire

class API: NSObject {
    
    // MARK: - Post
    func login() {
        let login = Login(username: "teste@teste.com.br", password: "abc123@")
        Alamofire.request("https://api.mobile.test.solutis.xyz/login", method: .post, parameters: ["username":login.username,"password":login.password],encoding: JSONEncoding()).responseJSON { (response) in
            switch response.result {
            case .success:
                if let resposta = response.result.value as? Dictionary<String,Any> {
                    print(resposta)
                }
                case .failure:
                    print(response.error!)
            }
        }
    }
    
    // MARK: - Get
    func pegaExtrato() {
        
    }
}

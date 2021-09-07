//
//  API.swift
//  Teste Solutis-Santander
//
//  Created by Virtual Machine on 06/09/21.
//

import UIKit
import Alamofire

class API: NSObject {
    var userDefaults = UserDefaults.standard
    var user = User(nome: "", saldo: 0, cpf: "", token: "")

    // MARK: - POST
    func login(_ username:String,_ password:String) {
        Alamofire.request("https://api.mobile.test.solutis.xyz/login", method: .post, parameters: ["username":username,"password":password],encoding: JSONEncoding()).responseJSON { (response) in
            switch response.result {
            case .success:
                if let resposta = response.result.value as? Dictionary<String,Any> {
                    print(resposta)
                    let userInfo = resposta
                    self.userDefaults.setValue(username, forKey: "email")
                    guard let nome = userInfo["nome"] as? String else {return}
                    guard let cpf = userInfo["cpf"] as? String else {return}
                    guard let saldo = userInfo["saldo"] as? Int else {return}
                    guard let token = userInfo["token"] as? String else {return}
                    self.user = User(nome: nome, saldo: saldo, cpf: cpf, token: token)
                }
                case .failure:
                    print(response.error!)
            }
        }
    }
    
    // MARK: - GET
    func pegaExtrato(_ token:String) -> Array<Dictionary<String,Any>> {
        var listaExtrato:Array<Dictionary<String,Any>> = []
        Alamofire.request("https://api.mobile.test.solutis.xyz/extrato", method: .get,encoding: JSONEncoding(), headers: ["token":token]).responseJSON { (response) in switch response.result {
        case .success:
            if let resposta = response.result.value as? Array<Dictionary<String,Any>> {
                print(resposta)
                listaExtrato = resposta
            }
        case .failure:
            print(response.error!)
            }
        }
        return listaExtrato
    }
}

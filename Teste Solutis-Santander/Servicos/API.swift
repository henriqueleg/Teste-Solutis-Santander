//
//  API.swift
//  Teste Solutis-Santander
//
//  Created by Virtual Machine on 06/09/21.
//

import UIKit
import Alamofire

class API: NSObject {
    var user = UserDefaults.standard
    var infoUsuario:Dictionary<String,Any> = [:]

    // MARK: - POST
    func login() -> Dictionary<String,Any> {
        var userData:Dictionary<String,Any> = [:]
        let login = Login(username: "teste@teste.com.br", password: "abc123@")
        Alamofire.request("https://api.mobile.test.solutis.xyz/login", method: .post, parameters: ["username":login.username,"password":login.password],encoding: JSONEncoding()).responseJSON { (response) in
            switch response.result {
            case .success:
                if let resposta = response.result.value as? Dictionary<String,Any> {
                    print(resposta)
                    let userInfo = resposta
                    userData = userInfo
                    self.user.setValue(login.password, forKey: "email")
                    guard let nome = userInfo["nome"] else {return}
                    guard let cpf = userInfo["cpf"] else {return}
                    guard let saldo = userInfo["saldo"] else {return}
                    guard let token = userInfo["token"] else {return}

                    self.infoUsuario = ["nome":nome,
                                        "cpf":cpf,
                                        "saldo":saldo,
                                        "token":token]
                    
                    self.pegaExtrato()
                }
                case .failure:
                    print(response.error!)
            }
        }
        return userData
    }
    
    // MARK: - GET
    func pegaExtrato() -> Array<Dictionary<String,Any>> {
        var listaExtrato:Array<Dictionary<String,Any>> = []
        guard let token = self.infoUsuario["token"] as? String else { return [] }
        
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

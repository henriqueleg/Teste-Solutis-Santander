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
    var listaExtrato:Array<Extratos> = []
    var succeeded = false

    // MARK: - POST
    func login(_ username:String,_ password:String, completion: @escaping (_ usuario:User?) -> Void)  {
        var user = User(nome: "", saldo: 0, cpf: "", token: "")
        Alamofire.request("https://api.mobile.test.solutis.xyz/login", method: .post, parameters: ["username":username,"password":password],encoding: JSONEncoding()).responseJSON { (response) in
            switch response.result {
            case .success:
                if let resposta = response.result.value as? Dictionary<String,Any> {
                    
                    if response.response!.statusCode > 299 {
                        completion(nil)
                        return
                    }
                    
                    let userInfo = resposta
                    guard let nome = userInfo["nome"] as? String,
                          let cpf = userInfo["cpf"] as? String,
                          let saldo = userInfo["saldo"] as? Double,
                          let token = userInfo["token"] as? String
                    else {
                        completion(nil)
                        return
                    }
                    user = User(nome: nome, saldo: saldo, cpf: cpf, token: token)
                    self.user = user
                    self.succeeded = true
                    completion(user)
                    break
                }
                case .failure:
                    print(response.error!)
                    self.user = user
                    completion(user)
                    break
            }
        }
    }
    
    // MARK: - GET
    func pegaExtrato(_ token:String, completion: @escaping (_ lista:Array<Extratos>)->()) {
        Alamofire.request("https://api.mobile.test.solutis.xyz/extrato", method: .get,encoding: JSONEncoding(), headers: ["token":token]).responseJSON { (response) in switch response.result {
        case .success:
            let resposta = try! JSONDecoder().decode([Extratos].self, from: response.data!) 
                self.listaExtrato = resposta
                completion(self.listaExtrato)
                break
            
        case .failure:
            print(response.error!)
            break
            }
        }
    }
}

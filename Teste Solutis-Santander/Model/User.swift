//
//  UserRepository.swift
//  Teste Solutis-Santander
//
//  Created by Virtual Machine on 06/09/21.
//

import UIKit

class User: NSObject {
    var nome:String
    var saldo:Int
    var cpf:String
    var token:String
    
    init(nome:String, saldo:Int,cpf:String,token:String) {
        self.nome = nome
        self.saldo = saldo
        self.cpf = cpf
        self.token = token
    }
}

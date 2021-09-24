//
//  UserRepository.swift
//  Teste Solutis-Santander
//
//  Created by Virtual Machine on 06/09/21.
//

import UIKit

struct User {
    var nome:String
    var saldo:Double
    var cpf:String
    var token:String
    
    var formatedSaldo: String {
        return Formatter().formataValor(saldo)
    }
    var formatedCpf: String {
        return Formatter().formataCPF(cpf)
    }
}

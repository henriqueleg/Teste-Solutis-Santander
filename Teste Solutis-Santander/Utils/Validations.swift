//
//  Validations.swift
//  Teste Solutis-Santander
//
//  Created by Virtual Machine on 08/09/21.
//

import Foundation
import CPF_CNPJ_Validator

class Validation {
    
    func validaCpfOuCnpj(_ CpfOuCnpj:String) -> Bool {
        let cpf = BooleanValidator().validate(CpfOuCnpj, kind: .CPF)
        let cnpj = BooleanValidator().validate(CpfOuCnpj, kind: .CNPJ)
        
        return cpf||cnpj
    }
    
    func validaEmail(_ email:String) -> Bool {
        let regex = "[A-Z0-9a-z.%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return emailPred.evaluate(with: email)
    }
    
    func validaSenha(_ password:String) -> Bool {
        if password != "" {
        let passwordRegx = "^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{6,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)
        }
        return false
    }
    
    func validaTudo(_ username:String,_ password:String ) -> Bool {
        if validaEmail(username) || validaCpfOuCnpj(username) {
            if validaSenha(password) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}

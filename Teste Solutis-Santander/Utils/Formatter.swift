//
//  Formatter.swift
//  Teste Solutis-Santander
//
//  Created by Virtual Machine on 10/09/21.
//

import UIKit

class Formatter: NSObject {

    func formataValor (_ valor:Double) -> String {
        var formatedValue = String(format: "%.2f", valor)
        formatedValue = "R$ " + formatedValue.replacingOccurrences(of: ".", with: ",")
        return formatedValue
    }
    
    func formataCPF(_ cpf:String) -> String {
        var i = 0
        var novoCpf:String = ""
        for numero in cpf {
            if i == 3 || i == 6 {
                novoCpf.append(".")
            } else if i == 9 {
                novoCpf.append("-")
            }
            novoCpf.append(numero)
            i+=1
        }
        return novoCpf
    }
    
    func formataData(_ data:String) -> String{
        let dataErrada = DateFormatter()
        dataErrada.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let wrongDate = dataErrada.date(from: data)!
        let dataCerta = DateFormatter()
        dataCerta.dateFormat = "dd/MM/yyyy"
        let fixedDate = dataCerta.string(from: wrongDate)
        return fixedDate
        
    }
}

//
//  Extratos.swift
//  Teste Solutis-Santander
//
//  Created by Virtual Machine on 08/09/21.
//

import UIKit

struct Extratos: Decodable {

    let valor:Double
    let descricao:String
    let data:String
    
    var formatedValor: String {
        return Formatter().formataValor(valor)
    }
    
    var formatedData: String {
        return Formatter().formataData(data)
    }
    
    
}

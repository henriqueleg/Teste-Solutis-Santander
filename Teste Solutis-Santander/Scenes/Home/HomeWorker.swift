//
//  HomeWorker.swift
//  Teste Solutis-Santander
//
//  Created by Virtual Machine on 23/09/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class HomeWorker
{
    private let api = API()
    
    func pegaExtratos (token: String, completion: @escaping (_ lista:Array<Extratos>)->()) {
    api.pegaExtrato(token) { listaExtratos in
        completion(listaExtratos)
    }
        return
    }
}

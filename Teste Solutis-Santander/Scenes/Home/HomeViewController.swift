//
//  HomeViewController.swift
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

protocol HomeDisplayLogic: AnyObject
{
    func displaySomething(viewModel: Home.UserData.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic
{
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doSomething()
    }
    
    // MARK: Do something
    
    @IBOutlet weak var nomeTextField: UILabel!
    @IBOutlet weak var saldoTextField: UILabel!
    @IBOutlet weak var cpfTextField: UILabel!
    
    func doSomething()
    {
        let request = Home.UserData.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Home.UserData.ViewModel)
    {
        nomeTextField.text = viewModel.user.nome
        saldoTextField.text = String(viewModel.user.saldo)
        cpfTextField.text = viewModel.user.cpf
    }
    
    //MARK: - Tableview
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listaExtratos.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaExtrato", for: indexPath) as! ExtratoViewCell
//        cell.descricaoLabel.text = listaExtratos[indexPath.row].descricao
//        cell.dataLabel.text = formatter.formataData(listaExtratos[indexPath.row].data)
//        cell.valorLabel.text = formatter.formataValor(listaExtratos[indexPath.row].valor)
//        if listaExtratos[indexPath.row].valor < 0 {
//            cell.tipoLabel.text = "Pagamento"
//            cell.valorLabel.textColor = UIColor.red
//        } else {
//            cell.tipoLabel.text = "Recebimento"
//            cell.valorLabel.textColor = UIColor(red: 17.0/255.0, green: 200.0/255.0, blue: 0.0/255.0, alpha: 1.0)
//        }
//        return cell
//    }
}

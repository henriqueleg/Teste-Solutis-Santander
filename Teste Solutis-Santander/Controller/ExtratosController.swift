//
//  ExtratosController.swift
//  Teste Solutis-Santander
//
//  Created by Virtual Machine on 07/09/21.
//

import Foundation
import UIKit

class ExtratosController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var nomeTextField: UILabel!
    @IBOutlet weak var cpfTextField: UILabel!
    @IBOutlet weak var saldoTextField: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func logoutButton(_ sender: Any) {
        showAlert()
    }
    
    var userInfo = User(nome: "", saldo: 0.0, cpf: "", token: "")
    var listaExtratos:Array<Extratos> = []
    let api = API()
    
    //MARK: - Startview
    override func viewDidLoad() {
        super.viewDidLoad()
            api.pegaExtrato(userInfo.token, completion: { listaExtratos in
                self.listaExtratos = self.api.listaExtrato
                self.tableView.reloadData()
        })
        nomeTextField.text = userInfo.nome
        cpfTextField.text = formataCPF(userInfo.cpf)
        saldoTextField.text = formataValor(userInfo.saldo)
        gradient()
    }
    
    //MARK: - Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaExtratos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaExtrato", for: indexPath) as! ExtratoViewCell
        cell.descricaoLabel.text = listaExtratos[indexPath.row].descricao
        cell.dataLabel.text = formataData(listaExtratos[indexPath.row].data)
        cell.valorLabel.text = formataValor(listaExtratos[indexPath.row].valor)
        if listaExtratos[indexPath.row].valor < 0 {
            cell.tipoLabel.text = "Pagamento"
        } else {
            cell.tipoLabel.text = "Recebimento"
        }
        if listaExtratos[indexPath.row].valor > 0 {
            cell.valorLabel.textColor = UIColor(red: 17.0/255.0, green: 200.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        } else {
            cell.valorLabel.textColor = UIColor.red
        }
        return cell
    }
    
    // MARK: - Alert
    func showAlert() {
        let logoutAlert = UIAlertController(title: "Sair", message: "Deseja mesmo sair?", preferredStyle: UIAlertController.Style.alert)
        logoutAlert.addAction(UIAlertAction(title: "Sair", style: .default, handler: { (action:UIAlertAction!) in
            self.performSegue(withIdentifier: "logout", sender: self)
        }))
        logoutAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action:UIAlertAction!) in
            logoutAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(logoutAlert, animated: true, completion: nil)
    }
    
    // MARK: - Formatters
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
    
    //MARK: - Gradient
    func gradient() {
        let gradientColor = CAGradientLayer()
        gradientColor.colors = [UIColor(red: 176.0/255.0, green: 226.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor,UIColor(red: 28.0/255.0, green: 120.0/255.0, blue: 212.0/255.0, alpha: 1.0).cgColor]
        gradientColor.frame = gradientView.bounds
        gradientColor.startPoint = CGPoint(x: 0, y: 1)
        gradientColor.endPoint = CGPoint(x: 1, y: 1)
        gradientView.layer.insertSublayer(gradientColor, at: 0)
    }
}


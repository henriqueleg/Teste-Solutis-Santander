//
//  ViewController.swift
//  Teste Solutis-Santander
//
//  Created by Virtual Machine on 06/09/21.
//

import UIKit
import KeychainSwift
import SVProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtonVisual: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    let keychain = KeychainSwift()
    var api = API()
    var succeded:Bool = false
    
    @IBOutlet weak var usernameSwitch: UISwitch!
    @IBAction func usernameSwitchPressed(_ sender: UISwitch) {
        if sender.isOn {
            keychain.set(true, forKey: "salvaUsuario")
        }
        if sender.isOn == false {
            keychain.delete("username")
            keychain.set(false, forKey: "salvaUsuario")
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        self.loginButtonVisual.isEnabled = false
        SVProgressHUD.show()
        errorLabel.isHidden = true
        guard let username = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        let validator = Validation()
        
        if validator.validaEmail(username) || validator.validaCpfOuCnpj(username) {
            
            if validator.validaSenha(password) {
                
            api.login(username, password) { (user) in
                self.loginButtonVisual.isEnabled = true
                SVProgressHUD.dismiss()
                if (self.api.succeeded == false) {
                    self.errorLabel.isHidden = false
                    self.passwordTextField.text = ""
                    }
                else if self.api.succeeded == true {
                    if self.usernameSwitch.isOn {
                        self.keychain.set(username, forKey: "username")
                    }
                    self.performSegue(withIdentifier: "extratos", sender: self)
                    }
                }
            }
            else {
                SVProgressHUD.dismiss()
                errorLabel.isHidden = false
                passwordTextField.text = ""
                self.loginButtonVisual.isEnabled = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if keychain.getBool("salvaUsuario") == true {
            usernameSwitch.isOn = true
        } else {
            usernameSwitch.isOn = false
        }
        errorLabel.isHidden = true
        loginTextField.addTarget(self, action:#selector(edited),
                                 for : .editingChanged)
        passwordTextField.addTarget(self, action:#selector(edited),
                                    for : .editingChanged)

        loginButtonVisual.layer.cornerRadius = 20
        loginButtonVisual.clipsToBounds = true
        loginTextField.layer.cornerRadius = 15
        loginTextField.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.clipsToBounds = true
        
        if keychain.get("username") != nil {
            loginTextField.text = keychain.get("username")
        }
        // Do any additional setup after loading the view.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "extratos" {
            let novaTela = segue.destination as! ExtratosController
            novaTela.userInfo = api.user        }
    }
    
    @objc func edited() {
        errorLabel.isHidden = true
    }
}


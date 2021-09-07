//
//  ViewController.swift
//  Teste Solutis-Santander
//
//  Created by Virtual Machine on 06/09/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButtonVisual: UIButton!
    
    @IBAction func loginButton(_ sender: Any) {
        guard let username = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        API().login(username,password)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButtonVisual.layer.cornerRadius = 20
        loginButtonVisual.clipsToBounds = true
        loginTextField.layer.cornerRadius = 15
        loginTextField.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.clipsToBounds = true
        let userDefaults = UserDefaults.standard
        if userDefaults.value(forKey: "email") != nil {
            loginTextField.text = userDefaults.string(forKey: "email")
        }
        // Do any additional setup after loading the view.
        
    }


}


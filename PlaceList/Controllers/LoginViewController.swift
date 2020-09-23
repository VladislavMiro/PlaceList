//
//  LoginViewController.swift
//  PlaceList
//
//  Created by Vladislav Miroshnichenko on 23.09.2020.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: loginTextField!
    @IBOutlet weak var passwordTextField: loginTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func loginButton(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        let alert = UIAlertController(title: "Error", message: "\(email) \(password)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapNotOnKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapNotOnKeyboard() {
        view.endEditing(true)
    }
}
//: Поднятие view на размер клавиатуры
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    
        if textField.frame.origin.y <= 50 {
            self.view.frame.origin.y -= textField.frame.origin.y
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}



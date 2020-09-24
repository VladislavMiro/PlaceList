//
//  LoginViewController.swift
//  PlaceList
//
//  Created by Vladislav Miroshnichenko on 23.09.2020.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var textFieldPosition : CGFloat = 0.0
    
    @IBOutlet weak var emailTextField: loginTextField!
    @IBOutlet weak var passwordTextField: loginTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObserver()
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
    
}
//: Поднятие view на размер клавиатуры
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldPosition = textField.frame.origin.y + textField.frame.height * 0.5
        print("\(textFieldPosition)")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case emailTextField:
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String:Any],
              let _ = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        
        UIView.animate(withDuration: 0.4) {
            self.view.transform = CGAffineTransform(translationX: 0.0, y: -self.textFieldPosition)
        }
    }
    
    @objc private func keyboardDidHide(notification: Notification) {
        UIView.animate(withDuration: 0.1) {
            self.view.transform = .identity
        }
    }
    /*func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.frame.origin.y <= 55 {
            self.view.frame.origin.y -= textField.frame.origin.y
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }*/
    
}



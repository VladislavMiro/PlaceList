//
//  RegisterViewController.swift
//  PlaceList
//
//  Created by Vladislav Miroshnichenko on 23.09.2020.
//

import UIKit

class RegisterViewController: UIViewController {

    private var textFieldPosition: CGFloat = 0.0
    private let datePicker = UIDatePicker()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShowDatePicker()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObserver()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObserver()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        if passwordTextField != confirmPasswordTextField {
            passwordTextField.backgroundColor = .red
            confirmPasswordTextField.backgroundColor = .red
            passwordError()
        }
    }
    
    private func ShowDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        guard let localeID = Locale.preferredLanguages.first else { return }
        datePicker.locale = Locale(identifier: localeID)
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.setItems([flexSpace, doneButton], animated: true)
        birthdayTextField.inputAccessoryView = toolBar
        birthdayTextField.inputView = datePicker
    }
    
    @objc private func doneAction() {
        birthdayTextField.resignFirstResponder()
        emailTextField.becomeFirstResponder()
        let formater = DateFormatter()
        formater.dateFormat = "dd.MM.yyyy"
        birthdayTextField.text = formater.string(from: datePicker.date)
    }
    
    private func passwordError() {
        let alert = UIAlertController(title: "Error", message: "Wrong password!", preferredStyle: .alert)
        let OKButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(OKButton)
        present(alert, animated: true)
    }
    

}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldPosition = textField.frame.origin.y + textField.frame.height
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case nameTextField:
            textField.resignFirstResponder()
            surnameTextField.becomeFirstResponder()
        case surnameTextField:
            textField.resignFirstResponder()
            birthdayTextField.becomeFirstResponder()
        case emailTextField:
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            textField.resignFirstResponder()
            confirmPasswordTextField.becomeFirstResponder()
        case confirmPasswordTextField:
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
              let keyboardSize = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        
        let distanceBetweenTextFieldAndKeyboard = self.view.frame.height - textFieldPosition - keyboardSize.height
        print("\(distanceBetweenTextFieldAndKeyboard)")
        if distanceBetweenTextFieldAndKeyboard < 200 {
            UIView.animate(withDuration: 0.4) {
                    self.view.transform = CGAffineTransform(translationX: 0.0, y: -distanceBetweenTextFieldAndKeyboard)
            }
        }
    }
    
    @objc private func keyboardDidHide(notification: Notification) {
        UIView.animate(withDuration: 0.4) {
            self.view.transform = .identity
        }
    }
    
}

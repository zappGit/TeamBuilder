//
//  Extension.swift.swift
//  TeamBuilder
//
//  Created by Артем Хребтов on 21.11.2021.
//

import Foundation
import UIKit

extension UITableViewCell {
    func setupLabel(label: UILabel, text: String?) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.layer.cornerRadius = 10
        label.text = text
        label.textAlignment = .left
    }
}

extension UIViewController {
    //конфигуратор UILabel
    func setupLabel(label: UILabel, text: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.layer.cornerRadius = 10
        label.text = text
        label.textAlignment = .center
        label.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        label.layer.borderWidth = 1
    }
    //конфигуратор UITextField
    func setupTextField(textField: UITextField, placeholder: String){
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = .black
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        textField.placeholder = placeholder
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    //конфигуратор UIButton
    func setupButton(button: UIButton, color: UIColor, text: String) {
        button.backgroundColor = color
        button.setTitleColor(.black, for: .normal)
        button.setTitle(text, for: .normal)
        button.layer.cornerRadius = 10
        //button.translatesAutoresizingMaskIntoConstraints = false
    }
    //Убрать клавиатуру по тапу
    func hideKeyWhenTap() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIViewController.dissmisKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dissmisKeyboard(){
        view.endEditing(true)
    }
    //алерт
    func errorAlert(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

}

//
//  UIViewController+Ext.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

import UIKit

extension UIViewController {

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(
        title: String = "",
        message: String = "",
        completion: @escaping () -> Void? = { nil }
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .default) { _ in completion() }
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertTwoActions(
        title: String = "",
        message: String = "",
        leftButtonTitle: String = "Ok",
        rightButtonTitle: String = "Liberar vaga",
        leftLabels: Bool = false,
        completion: @escaping () -> Void? = { nil }
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: leftButtonTitle, style: .cancel)
        alert.addAction(ok)
        let vacate = UIAlertAction(title: rightButtonTitle, style: .default) { _ in completion() }
        vacate.setValue(UIColor.systemRed, forKey: "titleTextColor")
        alert.addAction(vacate)
        
        if leftLabels {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            let messageText = NSAttributedString(
                string: message,
                attributes: [
                    NSAttributedString.Key.paragraphStyle: paragraphStyle,
                    NSAttributedString.Key.foregroundColor: UIColor(named: "grayDarkest"),
                    NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 15)
                ]
            )
            alert.setValue(messageText, forKey: "attributedMessage")
        }
        self.present(alert, animated: true, completion: nil)
    }
}

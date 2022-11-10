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
        completion: @escaping () -> Void? = { nil }
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        let vacate = UIAlertAction(title: "Liberar vaga", style: .default) { _ in completion() }
        vacate.setValue(UIColor.systemRed, forKey: "titleTextColor")
        alert.addAction(vacate)
        self.present(alert, animated: true, completion: nil)
    }
}

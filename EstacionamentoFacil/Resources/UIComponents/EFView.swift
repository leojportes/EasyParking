//
//  EFView.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 09/11/22.
//

import UIKit

class EFView: UIView {
    
    var activeTextField: UITextField? = nil
    var shouldHiddenNavigationBar: (Bool) -> Void = { _ in }
    
    init() {
        super.init(frame: .zero)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {

        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        var shouldMoveViewUp = false

        // if active text field is not nil
        if let activeTextField = activeTextField {

            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self).maxY;
            let topOfKeyboard = self.frame.height - keyboardSize.height

            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }

        if shouldMoveViewUp {
            self.frame.origin.y = 0 - keyboardSize.height
            self.shouldHiddenNavigationBar(true)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.frame.origin.y = 0
        self.shouldHiddenNavigationBar(false)
    }
    
}

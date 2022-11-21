//
//  LoginViewController.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 24/10/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: CoordinatedViewController {
    
    // MARK: - Private properties
    private let viewModel: LoginViewModelProtocol

    private lazy var rootView = LoginView(
        didTapLogin: weakify { $0.didTapLogin($1, $2) },
        didTapCreateAccount: weakify { $0.viewModel.navigateToCreateAccount() }
    )

    // MARK: - Init
    init(viewModel: LoginViewModelProtocol, coordinator: CoordinatorProtocol) {
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = rootView
        hideKeyboardWhenTappedAround()
        
        // 2022-11-15 20:12:22 +0000
        let dateFormatter = DateFormatter()
        
        // 3.1 Portuguese Brazil Locale (pt_BR)
        let date = Date()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy HH:mm")// // set template after setting locale
   
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    func didTapLogin(_ email: String, _ password: String) {
        rootView.loginButton.loadingIndicator(show: true)
        viewModel.authLogin(email, password) { [weak self] onSuccess, descriptionError in
            onSuccess
            ? DispatchQueue.main.async { self?.viewModel.navigateToHome() }
            : DispatchQueue.main.async { self?.showError(descriptionError) }
        }
    }
    
    private func showError( _ descriptionError: String) {
        self.showAlert(title: "Atenção", message: descriptionError)
        self.rootView.loginButton.loadingIndicator(show: false)
    }
//
//    func didTapForgotPassword() {
//        viewModel.navigateToForgotPassword(email: self.email)
//    }
//
//    func didTapRegister() {
//        viewModel.navigateToRegister()
//    }
//
}

extension Date {
    func minutes(from date: Date) -> Int {
         return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    func offset(from date: Date) -> String {
        //           if years(from: date)   > 0 { return "\(years(from: date))y"   }
        //           if months(from: date)  > 0 { return "\(months(from: date))M"  }
        //           if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        //           if days(from: date)    > 0 { return "\(days(from: date))d"    }
        //           if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))" }
        //           if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

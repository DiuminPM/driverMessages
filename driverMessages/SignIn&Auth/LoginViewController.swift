//
//  LoginViewController.swift
//  driverMessages
//
//  Created by DiuminPM on 15.10.2021.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {
    
    let helloLabel = UILabel(text: "Welcome Back!", font: .avenir26())
    let loginWithLabel = UILabel(text: "Login with")
    let orLabel = UILabel(text: "or")
    let needAnAccountLabel = UILabel(text: "Need an account?")
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true, cornerRadius: 4)
    let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .buttonDark(), cornerRadius: 4)
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
    }()
    
    weak var delegate: AuthNavigatingDelegate?
    
    let emailTF = OneLineTextField(font: .avenir20())
    let passwordTF = OneLineTextField(font: .avenir20())

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        view.backgroundColor = .white
        googleButton.customaizedGoogleButon()
        
        loginButton.addTarget(self, action: #selector(loginButtonTaped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTaped), for: .touchUpInside)

    }
    
    @objc private func loginButtonTaped() {
        print(#function)
        AuthService.shared.login(email: emailTF.text, password: passwordTF.text) { result in
            switch result{
            
            case .success(let user):
                self.showAlert(with: "Успешно!", and: "Вы авторизованы") {
                    FireStoreService.shared.getUserData(user: user) { (result) in
                        switch result {
                        case .success(let muser):
                            self.present(MainTabBarController(), animated: true, completion: nil)
                        case .failure(_):
                            self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                        }
                    }
                }
            case .failure(let error):
                self.showAlert(with: "Ошибка!", and: error.localizedDescription)
            }
        }
    }
    
    @objc private func signUpButtonTaped() {
        dismiss(animated: true) {
            self.delegate?.toSignUpVC()
        }
    }
    
}

// MARK: - Setup constants
extension LoginViewController {
    private func setupConstraints() {
        
        googleButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        let loginWithView = ButtonFormView(label: loginWithLabel, button: googleButton)
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTF], axis: .vertical, spacing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTF], axis: .vertical, spacing: 0)
        let stackView = UIStackView(arrangedSubviews: [loginWithView, orLabel, emailStackView, passwordStackView, loginButton], axis: .vertical, spacing: 40)
        
        signUpButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangedSubviews: [needAnAccountLabel, signUpButton], axis: .horizontal, spacing: 10)
        bottomStackView.alignment = .firstBaseline
        
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(helloLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            helloLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])


    }
}

// MARK: - SwiftUI
import SwiftUI

struct LoginViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let loginVC = LoginViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<LoginViewControllerProvider.ContainerView>) -> LoginViewController {
            return loginVC
        }
        
        func updateUIViewController(_ uiViewController: LoginViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<LoginViewControllerProvider.ContainerView>) {
            
        }
    }
}

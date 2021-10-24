//
//  ViewController.swift
//  driverMessages
//
//  Created by DiuminPM on 14.10.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "pngwing.com-1"), contentMode: .scaleAspectFit)
    
    
    let googleLabel = UILabel(text: "Get started with")
    let emailLabel = UILabel(text: "Or sigh up with")
    let alreadyOnBoardLabel = UILabel(text: "Already on board?")

    
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .buttonDark())
    let loginButton = UIButton(title: "Login", titleColor: .buttonRed(), backgroundColor: .white, isShadow: true)
    
    let signUpVC = SignUpViewController()
    let loginVC = LoginViewController()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        googleButton.customaizedGoogleButon()
        
        emailButton.addTarget(self, action: #selector(emailButtonTaped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTaped), for: .touchUpInside)
        
        signUpVC.delegate = self
        loginVC.delegate = self


    }
    
    @objc private func emailButtonTaped() {
        print(#function)
        present(signUpVC, animated: true, completion: nil)
    }
    
    @objc private func loginButtonTaped() {
        print(#function)
        present(loginVC, animated: true, completion: nil)
    }

}

// MARK: - Setup constants
extension AuthViewController {
    private func setupConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let googleView = ButtonFormView(label: googleLabel, button: googleButton)
        let emailView = ButtonFormView(label: emailLabel, button: emailButton)
        let loginView = ButtonFormView(label: alreadyOnBoardLabel, button: loginButton)
        
        let stackView = UIStackView(arrangedSubviews: [googleView, emailView, loginView], axis: .vertical, spacing: 40)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 40
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])

    }
}

extension AuthViewController: AuthNavigatingDelegate {
    func toLoginVC() {
        present(loginVC, animated: true, completion: nil)
    }
    
    func toSignUpVC() {
        present(signUpVC , animated: true, completion: nil)

    }
    
    
}

// MARK: - SwiftUI
import SwiftUI 

struct ViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = AuthViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ViewControllerProvider.ContainerView>) -> AuthViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: ViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ViewControllerProvider.ContainerView>) {
            
        }
    }
}


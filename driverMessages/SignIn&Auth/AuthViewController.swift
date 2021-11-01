//
//  ViewController.swift
//  driverMessages
//
//  Created by DiuminPM on 14.10.2021.
//

import UIKit
import Firebase
import GoogleSignIn

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
        googleButton.addTarget(self, action: #selector(googleButtonTaped), for: .touchUpInside)

        
        signUpVC.delegate = self
        loginVC.delegate = self

//        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    
    @objc private func emailButtonTaped() {
        print(#function)
        present(signUpVC, animated: true, completion: nil)
    }
    
    @objc private func loginButtonTaped() {
        print(#function)
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc private func googleButtonTaped() {
        print(#function)
        AuthService.shared.googleLogIn(present: self)
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

extension AuthViewController {

    func googleSign() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if let error = error {
                self.showAlert(with: "Ошибка", and: error.localizedDescription)
            }
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { (result, error) in
                guard let result = result else { return }
                let user = result.user
                FireStoreService.shared.getUserData(user: user) { result in
                    switch result {
                    
                    case .success(let mUser):
                        UIApplication.getTopViewController()?.showAlert(with: "Успешно", and: "Вы авторизованы") {
                            let mainTabBar = MainTabBarController(currentUser: mUser)
                            mainTabBar.modalPresentationStyle = .fullScreen
                            UIApplication.getTopViewController()?.present(mainTabBar, animated: true, completion: nil)
                        }
                    case .failure(_):
                        UIApplication.getTopViewController()?.showAlert(with: "Успешно", and: "Вы зарегистрированны") {
                            UIApplication.getTopViewController()?.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                        }
                    }
                }
            }

        }
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


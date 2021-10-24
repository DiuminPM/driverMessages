//
//  ProfileViewController.swift
//  driverMessages
//
//  Created by DiuminPM on 22.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let conteinerView = UIView()
    let imageView = UIImageView(image: #imageLiteral(resourceName: "human2"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "Peter Ben", font: .systemFont(ofSize: 20, weight: .light))
    let aboutMeLabel = UILabel(text: "You have the opportunity to chat witth the best man in the world", font: .systemFont(ofSize: 16, weight: .light))
    let myTextField = InsertableTextField()
    
    private func customizedElements() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        
        aboutMeLabel.numberOfLines = 0
        conteinerView.backgroundColor = .mainWhite()
        conteinerView.layer.cornerRadius = 30
        
        if let button = myTextField.rightView as? UIButton {
            button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        }

    }
    
    @objc private func sendMessage() {
        print(#function)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizedElements()
        setupConstraits()
    }
}

extension ProfileViewController {
    private func setupConstraits() {
        view.addSubview(imageView)
        view.addSubview(conteinerView)
        conteinerView.addSubview(nameLabel)
        conteinerView.addSubview(aboutMeLabel)
        conteinerView.addSubview(myTextField)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 30)

        ])
        
        NSLayoutConstraint.activate([
            conteinerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            conteinerView.heightAnchor.constraint(equalToConstant: 206)

        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 35),
            nameLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            aboutMeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            aboutMeLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 24),
            aboutMeLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            myTextField.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 8),
            myTextField.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 24),
            myTextField.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -24),
            myTextField.heightAnchor.constraint(equalToConstant: 48)

        ])

    }
}

// MARK: - SwiftUI
import SwiftUI

struct ProfileViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let profileViewController = ProfileViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProfileViewControllerProvider.ContainerView>) -> ProfileViewController {
            return profileViewController
        }
        
        func updateUIViewController(_ uiViewController: ProfileViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProfileViewControllerProvider.ContainerView>) {
            
        }
    }
}

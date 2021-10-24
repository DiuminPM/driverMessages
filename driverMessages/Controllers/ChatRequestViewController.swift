//
//  ChatRequestViewController.swift
//  driverMessages
//
//  Created by DiuminPM on 22.10.2021.
//

import UIKit

class ChatRequestViewController: UIViewController {
    
    let conteinerView = UIView()
    let imageView = UIImageView(image: #imageLiteral(resourceName: "human2"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "Peter Ben", font: .systemFont(ofSize: 20, weight: .light))
    let aboutMeLabel = UILabel(text: "You have the opportunity to start a new chat!", font: .systemFont(ofSize: 16, weight: .light))
    let acceptButton = UIButton(title: "ACCEPT", titleColor: .white, backgroundColor: .black, font: .laoSangamMN20(), isShadow: false, cornerRadius: 10)
    let denyButton = UIButton(title: "Deny", titleColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), backgroundColor: .mainWhite(), font: .laoSangamMN20(), isShadow: false, cornerRadius: 10)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedElements()
        setupConstraits()
    }
    
    private func customizedElements() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        aboutMeLabel.numberOfLines = 0
        conteinerView.backgroundColor = .mainWhite()
        conteinerView.layer.cornerRadius = 30
        denyButton.layer.borderWidth = 1.2
        denyButton.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.acceptButton.applyGradients(cornerRadius: 10)
    }
    
}

extension ChatRequestViewController {
    private func setupConstraits() {
        view.addSubview(imageView)
        view.addSubview(conteinerView)
        conteinerView.addSubview(nameLabel)
        conteinerView.addSubview(aboutMeLabel)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [acceptButton, denyButton], axis: .horizontal, spacing: 8)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.distribution = .fillEqually
        conteinerView.addSubview(buttonsStackView)
        
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
            buttonsStackView.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 24),
            buttonsStackView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 24),
            buttonsStackView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -24),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 56)

        ])

    }
}

// MARK: - SwiftUI
import SwiftUI

struct ChatRequestViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let chatRequestVC = ChatRequestViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ChatRequestViewControllerProvider.ContainerView>) -> ChatRequestViewController {
            return chatRequestVC
        }
        
        func updateUIViewController(_ uiViewController: ChatRequestViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ChatRequestViewControllerProvider.ContainerView>) {
            
        }
    }
}

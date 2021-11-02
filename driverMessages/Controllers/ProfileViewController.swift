//
//  ProfileViewController.swift
//  driverMessages
//
//  Created by DiuminPM on 22.10.2021.
//

import UIKit
import  SDWebImage

class ProfileViewController: UIViewController {
    
    let conteinerView = UIView()
    let imageView = UIImageView(image: #imageLiteral(resourceName: "human2"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "Peter Ben", font: .systemFont(ofSize: 20, weight: .light))
    let aboutMeLabel = UILabel(text: "You have the opportunity to chat witth the best man in the world", font: .systemFont(ofSize: 16, weight: .light))
    let myTextField = InsertableTextField()
    
    private let user: MUser
    
    init(user: MUser) {
        self.user = user
        self.nameLabel.text = user.userName
        self.aboutMeLabel.text = user.description
        self.imageView.sd_setImage(with: URL(string: user.avatarStringURL), completed: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    @objc private func sendMessage() {guard let message = myTextField.text, message != "" else { return }
        self.dismiss(animated: true) {
            FireStoreService.shared.createWaitingChat(message: message, receiver: self.user) { result in
                switch result {
                
                case .success:
                    UIApplication.getTopViewController()?.showAlert(with: "Успешно", and: "ваше сообщение отправлено для \(self.user.userName)")

                case .failure(let error):
                    UIApplication.getTopViewController()?.showAlert(with: "ошибка", and: error.localizedDescription)

                }
            }
             
        }
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



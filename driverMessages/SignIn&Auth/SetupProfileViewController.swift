//
//  SetupProfileViewController.swift
//  driverMessages
//
//  Created by DiuminPM on 16.10.2021.
//

import UIKit
import Firebase
import SDWebImage

class SetupProfileViewController: UIViewController {
    
    let fullImageView = AddPhotoView()
    
    let helloLabel = UILabel(text: "Set up profile!", font: .avenir26())
    let fullNameLabel = UILabel(text: "Full name")
    let aboutMeLabel = UILabel(text: "About me")
    let sexLabel = UILabel(text: "Sex")
    
    let fullNameTF = OneLineTextField(font: .avenir20())
    let aboutMeTF = OneLineTextField(font: .avenir20())
    
    let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Female")
    
    let goToChatsButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .buttonDark(), cornerRadius: 4)

    private let currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        
        if let userName = currentUser.displayName {
            fullNameTF.text = userName
        }
        
        if let photoURL = currentUser.photoURL {
            fullImageView.circleImageView.sd_setImage(with: photoURL, completed: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupConstraints()
        goToChatsButton.addTarget(self, action: #selector(goToChatsButtonTapped), for: .touchUpInside)
        fullImageView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    @objc private func plusButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func goToChatsButtonTapped() {
        
        FireStoreService.shared.saveProfileWith(id: currentUser.uid,
                                                email: currentUser.email!,
                                                userName: fullNameTF.text,
                                                avatarImage: fullImageView.circleImageView.image,
                                                description: aboutMeTF.text,
                                                sex: sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex)) { result in
            switch result {
            
            case .success(let mUser):
                self.showAlert(with: "Успешно!", and: "Данные сохранены!", completion: {
                    let mainTabBar = MainTabBarController(currentUser: mUser)
                    mainTabBar.modalPresentationStyle = .fullScreen
                    self.present(mainTabBar, animated: true, completion: nil)
                })            case .failure(let error):
                self.showAlert(with: "Ошибка!", and: error.localizedDescription)
            }
        }
        
    }
}

// MARK: - Setup constants
extension SetupProfileViewController {
    private func setupConstraints() {
        
        
        let fullNameStackView = UIStackView(arrangedSubviews: [fullNameLabel, fullNameTF], axis: .vertical, spacing: 10)
        let aboutMeStackView = UIStackView(arrangedSubviews: [aboutMeLabel, aboutMeTF], axis: .vertical, spacing: 10)
        let sexStackView = UIStackView(arrangedSubviews: [sexLabel, sexSegmentedControl], axis: .vertical, spacing: 10)
        
        let stackView = UIStackView(arrangedSubviews: [fullNameStackView,aboutMeStackView, sexStackView, goToChatsButton], axis: .vertical, spacing: 40)
        
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(helloLabel)
        view.addSubview(fullImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            helloLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            fullImageView.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: 30),
            fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        goToChatsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SetupProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        fullImageView.circleImageView.image = image
    }
}

// MARK: - SwiftUI
import SwiftUI

struct SetupProfileViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let setupProfileVC = SetupProfileViewController(currentUser: Auth.auth().currentUser!)
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SetupProfileViewControllerProvider.ContainerView>) -> SetupProfileViewController {
            return setupProfileVC
        }
        
        func updateUIViewController(_ uiViewController: SetupProfileViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SetupProfileViewControllerProvider.ContainerView>) {
            
        }
    }
}

//
//  SliderFormView.swift
//  driverMessages
//
//  Created by DiuminPM on 09.02.2022.
//

import UIKit

class SliderFormView: UIView {
    
    init(label: UILabel, slider: UISlider, button: UIButton) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(label)
        self.addSubview(slider)
        self.addSubview(button)

        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            slider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            slider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            slider.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        bottomAnchor.constraint(equalTo: slider.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

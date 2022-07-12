//
//  Popup.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 11.07.2022.
//

import Foundation
import UIKit

class Popup: UIView {
    
    let titleLabel = TitleLabel()
    var nameTextField = UITextField()
    let startTheGame = RegularButton()
    let backToMain = CloseButton()
    
    fileprivate let container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.8)
        container.layer.cornerRadius = 24
        return container
    }()
    
    fileprivate lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameTextField, startTheGame])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    /// Set later
    @objc fileprivate func animateOut() {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        })  { _ in self.removeFromSuperview() }
    }
    
    /// Set later
    @objc fileprivate func animateIn() {
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 1
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let constraint = Constraints.basic.rawValue
        
        let tapClose = UITapGestureRecognizer(target: self, action: #selector(animateOut))
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        backToMain.addGestureRecognizer(tapClose)
        self.addGestureRecognizer(tap)
        
        self.backgroundColor = .black
        self.frame = UIScreen.main.bounds
        
        self.addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(backToMain)
        container.addSubview(stack)
        
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: constraint).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -constraint).isActive = true
        titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: constraint).isActive = true
        titleLabel.text = "Подготовка"
        titleLabel.heightAnchor.constraint(equalToConstant: constraint * 3).isActive = true
        
        backToMain.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -constraint).isActive = true
        backToMain.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        
        stack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: constraint).isActive = true
        stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: constraint).isActive = true
        stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -constraint).isActive = true
        stack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -constraint).isActive = true
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder = "Введите имя игрока"
        nameTextField.borderStyle = .roundedRect
        nameTextField.clearButtonMode = .whileEditing
        
        startTheGame.setTitle("Начать игру", for: .normal)
        
        animateIn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}

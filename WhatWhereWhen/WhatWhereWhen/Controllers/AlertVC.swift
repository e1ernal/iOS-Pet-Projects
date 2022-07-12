//
//  Popup.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 11.07.2022.
//

import Foundation
import UIKit

extension UIViewController {
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

class AlertVC: UIViewController {
    
    let titleLabel = TitleLabel()
    var nameTextField = UITextField()
    let startTheGame = RegularButton()
    let backToMain = CloseButton()
    
    let container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.8)
        container.layer.cornerRadius = 24
        return container
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameTextField, startTheGame])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    @objc fileprivate func animateOut(completionHandler: @escaping () -> Void) {
        self.container.alpha = 1
        UIView.animate(withDuration: 1,
                       delay: 0.3,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: -0.25 * self.view.frame.height)
            self.container.alpha = 0
        }) { _ in
            completionHandler()
        }
    }
    
    @objc fileprivate func backToMainAction() {
        animateOut() {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc fileprivate func startTheGameAction() {
        guard let name = nameTextField.text, name != "" else {
            // Shake animation
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: nameTextField.center.x - 10, y: nameTextField.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: nameTextField.center.x + 10, y: nameTextField.center.y))
            
            nameTextField.layer.add(animation, forKey: "position")
            return
        }
        animateOut() {
            let nextVC: QuestionsVC = QuestionsVC()
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    @objc fileprivate func animateIn() {
        self.container.transform = CGAffineTransform(translationX: 0, y: -0.25 * self.view.frame.height)
        self.container.alpha = 0
        UIView.animate(withDuration: 1,
                       delay: 0.3,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {
            self.container.transform = .identity
            self.container.alpha = 1
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeUI()
    }
}

extension AlertVC {
    
    func makeUI() {
        let constraint = Constraints.basic.rawValue
        
        let tapClose = UITapGestureRecognizer(target: self, action: #selector(backToMainAction))
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        let tapStart = UITapGestureRecognizer(target: self, action: #selector(startTheGameAction))
        
        backToMain.addGestureRecognizer(tapClose)
        self.view.addGestureRecognizer(tap)
        startTheGame.addGestureRecognizer(tapStart)
        
        self.view.backgroundColor = .black
        self.view.frame = UIScreen.main.bounds
        
        self.view.addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(backToMain)
        container.addSubview(stack)
        
        container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        container.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: constraint).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -constraint).isActive = true
        titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: constraint).isActive = true
        titleLabel.text = "Игрок"
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
        
        container.alpha = 0
        
        self.animateIn()
    }
}

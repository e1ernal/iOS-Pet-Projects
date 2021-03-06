//
//  Popup.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 11.07.2022.
//

import Foundation
import UIKit

class PrepareVC: UIViewController {
    
    let titleLbl = TitleLabel()
    let closeBtn = ImageButton()
    let startBtn = RegularButton()
    var nameTxtFld = UITextField()
    
    let container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .systemGray6
        container.layer.cornerRadius = 24
        return container
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLbl, nameTxtFld, startBtn])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = Constraints.basic.rawValue
        return stack
    }()
    
    @objc fileprivate func closeBtnAction() {
        // MARK: Out Animation
        UIView.animate(with: .popup) {
            self.container.transform = CGAffineTransform(translationX: 0, y: -0.25 * self.view.frame.height)
            self.container.alpha = 0
        } completion: {_ in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func startBtnAction() {
        guard let name = nameTxtFld.text, name != "" else {
            // MARK: Shake animation of Text Field
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: nameTxtFld.center.x - 10, y: nameTxtFld.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: nameTxtFld.center.x + 10, y: nameTxtFld.center.y))
            nameTxtFld.layer.add(animation, forKey: "position")
            return
        }
        self.dismissKeyboard()
        // MARK: Out Animation
        UIView.animate(with: .popup) {
            self.container.transform = CGAffineTransform(translationX: 0, y: -0.25 * self.view.frame.height)
            self.container.alpha = 0
        } completion: {_ in
            let nextVC: QuestionsVC = QuestionsVC()
            nextVC.game.name = name
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        // MARK: Entry Animation
        container.transform = CGAffineTransform(translationX: 0, y: -0.25 * self.view.frame.height)
        UIView.animate(with: .popup) {
            self.container.transform = .identity
            self.container.alpha = 1
        } completion: {_ in }
    }
}

extension PrepareVC {
    
    func makeUI() {
        let constraint = Constraints.basic.rawValue
        
        let tapStart = UITapGestureRecognizer(target: self, action: #selector(startBtnAction))
        let tapClose = UITapGestureRecognizer(target: self, action: #selector(closeBtnAction))
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        startBtn.addGestureRecognizer(tapStart)
        closeBtn.addGestureRecognizer(tapClose)
        self.view.addGestureRecognizer(tap)
        
        self.view.backgroundColor = .black
        self.view.frame = UIScreen.main.bounds
        
        self.view.addSubview(container)
        container.addSubview(stack)
        container.addSubview(closeBtn)
        
        container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        
        stack.topAnchor.constraint(equalTo: container.topAnchor, constant: constraint).isActive = true
        stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: constraint).isActive = true
        stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -constraint).isActive = true
        stack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -constraint).isActive = true
        
        titleLbl.text = "??????????"
        
        nameTxtFld.translatesAutoresizingMaskIntoConstraints = false
        nameTxtFld.placeholder = "?????????????? ?????? ????????????"
        nameTxtFld.borderStyle = .roundedRect
        nameTxtFld.clearButtonMode = .whileEditing
        
        startBtn.setup(title: "???????????? ????????")
        
        closeBtn.setup(image: "xmark.circle")
        closeBtn.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -constraint).isActive = true
        closeBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor).isActive = true
        container.alpha = 0
    }
}

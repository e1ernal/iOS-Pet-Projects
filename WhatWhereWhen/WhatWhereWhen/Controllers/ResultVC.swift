//
//  ResultVC.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 15.07.2022.
//

import Foundation
import UIKit

class ResultVC: UIViewController {
    
    var score: Int = 0
    var time: Int = 0
    var maxScore: Int = 1000
    
    let titleLbl = TitleLabel()
    let closeBtn = ImageButton()
    let resultBtn = RegularButton()
    
    let scoreTitle = RegularLabel()
    let scoreLbl = RegularLabel()
    let timeTitle = RegularLabel()
    let timeLbl = RegularLabel()
    
    let container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .systemGray6
        container.layer.cornerRadius = 24
        return container
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLbl, scoreLbl, timeLbl, resultBtn])
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
    
    @objc fileprivate func resultBtnAction() {
        // MARK: Out Animation
        UIView.animate(with: .popup) {
            self.container.transform = CGAffineTransform(translationX: 0, y: -0.25 * self.view.frame.height)
            self.container.alpha = 0
        } completion: {_ in
            let nextVC: ScoreVC = ScoreVC()
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
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

extension ResultVC {
    
    func makeUI() {
        let constraint = Constraints.basic.rawValue
        
        let tapStart = UITapGestureRecognizer(target: self, action: #selector(resultBtnAction))
        let tapClose = UITapGestureRecognizer(target: self, action: #selector(closeBtnAction))
        
        resultBtn.addGestureRecognizer(tapStart)
        closeBtn.addGestureRecognizer(tapClose)
        
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
        
        titleLbl.text = "?????????? ????????"
        
        resultBtn.setup(title: "?????????????? ??????????????????????")
        
        scoreLbl.text = "??????????????????: \(score) ?????????? ???? \(maxScore)"
        scoreLbl.textAlignment = .left
        timeLbl.text  = "??????????: \(time / 60) ?????? \(time % 60) ??????"
        timeLbl.textAlignment = .left
        
        closeBtn.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -constraint).isActive = true
        closeBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor).isActive = true
        closeBtn.setup(image: "xmark.circle")
        container.alpha = 0
        
    }
}

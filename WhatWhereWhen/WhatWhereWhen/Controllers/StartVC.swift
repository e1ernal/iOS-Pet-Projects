//
//  StartVC.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 08.07.2022.
//

import Foundation
import UIKit

class StartVC: UIViewController {
    
    lazy var titleLbl = TitleLabel()
    lazy var startBtn = RegularButton()
    lazy var scoreBtn = RegularButton()
    lazy var settingsBtn = ImageButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        startBtn.addTarget(self, action: #selector(showQuestions), for: .touchUpInside)
        scoreBtn.addTarget(self, action: #selector(showScore), for: .touchUpInside)
    }
    
    @objc func showQuestions() {
        let nextVC: PrepareVC = PrepareVC()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func showScore() {
        let nextVC: ScoreVC = ScoreVC()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension StartVC {
    
    func makeUI() {
        self.view.backgroundColor = .black
        let constraint = Constraints.basic.rawValue
        
        self.view.addSubview(titleLbl)
        self.view.addSubview(startBtn)
        self.view.addSubview(scoreBtn)
        self.view.addSubview(settingsBtn)
        
        titleLbl.text = "<Что? Где? Когда?>"
        titleLbl.numberOfLines = 0
        titleLbl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: constraint).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        titleLbl.bottomAnchor.constraint(equalTo: startBtn.topAnchor, constant: -constraint).isActive = true
        
        startBtn.setup(title: "Играть")
        startBtn.titleLabel?.font = UIFont.systemFont(ofSize: TextSize.title.rawValue, weight: TextWeight.title.getWeight())
        startBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        startBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        startBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        settingsBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -constraint).isActive = true
        settingsBtn.topAnchor.constraint(equalTo: startBtn.bottomAnchor, constant: constraint).isActive = true
        settingsBtn.setup(image: "gear")
        
        scoreBtn.setup(title: "Результаты игр")
        scoreBtn.topAnchor.constraint(equalTo: startBtn.bottomAnchor, constant: constraint).isActive = true
        scoreBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        scoreBtn.trailingAnchor.constraint(equalTo: settingsBtn.leadingAnchor, constant: -constraint).isActive = true
    }
}

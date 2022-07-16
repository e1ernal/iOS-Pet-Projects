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
    lazy var scoreBtn = FurtherButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        startBtn.addTarget(self, action: #selector(showQuestions), for: .touchUpInside)
        scoreBtn.addTarget(self, action: #selector(showScore), for: .touchUpInside)
        print(scores.count)
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
        let labelTitle: String = """
                                 15 вопросов из игры
                                 <Что? Где? Когда?>
                                 """
        let startGameTitle: String = "Игра"
        let showScoreTitle: String = "Таблица результатов"
        
        self.view.backgroundColor = .black
        let constraint = Constraints.basic.rawValue
        
        self.view.addSubview(titleLbl)
        self.view.addSubview(startBtn)
        self.view.addSubview(scoreBtn)
        
        titleLbl.text = labelTitle
        titleLbl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: constraint).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        titleLbl.bottomAnchor.constraint(equalTo: startBtn.topAnchor, constant: -constraint).isActive = true
        
        startBtn.setTitle(startGameTitle, for: .normal)
        startBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        startBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        startBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        scoreBtn.setTitle(showScoreTitle, for: .normal)
        scoreBtn.topAnchor.constraint(equalTo: startBtn.bottomAnchor, constant: constraint).isActive = true
        scoreBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        scoreBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
    }
}

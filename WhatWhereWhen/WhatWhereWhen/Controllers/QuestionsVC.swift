//
//  QuestionsVC.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 09.07.2022.
//

import Foundation
import UIKit

class QuestionsVC: UIViewController {
    
    
    lazy var timerLbl = RegularLabel()
    lazy var questionNumberLbl = TitleLabel()
    lazy var questionTitleLbl = SubtitleLabel()
    lazy var questionLbl = RegularLabel()
    
    lazy var answer1Btn = RegularButton()
    lazy var answer2Btn = RegularButton()
    lazy var answer3Btn = RegularButton()
    lazy var getHintBtn = HintButton()
    
    var currentQuestion: Int8 = 0
    let timerTime = 15
    
    /* Get from CoreData */
    var questions: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*JSON request*/
        requestNetworkData()
        makeUI()
    }
}

extension QuestionsVC {
    
    func makeUI() {
        guard !questions.isEmpty else { return }
        
        let randAnswer = [0, 1, 2].shuffled()
        let answers = questions[Int(currentQuestion)].answers
        let constraint = Constraints.basic.rawValue
        
        timerLbl.text = String(timerTime) + ":00"
        questionNumberLbl.text = "Вопрос №\(currentQuestion + 1)"
        questionTitleLbl.text = "<\(questions[Int(currentQuestion)].title)>"
        questionLbl.text = questions[Int(currentQuestion)].question
        
        answer1Btn.setTitle(answers[randAnswer[0]], for: .normal)
        answer2Btn.setTitle(answers[randAnswer[1]], for: .normal)
        answer3Btn.setTitle(answers[randAnswer[2]], for: .normal)
        getHintBtn.setTitle("Использовать подсказку", for: .normal)
        
        self.view.addSubview(timerLbl)
        self.view.addSubview(questionNumberLbl)
        self.view.addSubview(questionTitleLbl)
        self.view.addSubview(questionLbl)
        self.view.addSubview(answer1Btn)
        self.view.addSubview(answer2Btn)
        self.view.addSubview(answer3Btn)
        self.view.addSubview(getHintBtn)
        
        timerLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        timerLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constraint).isActive = true
        timerLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        timerLbl.frame.size.height = 25
        
        questionNumberLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        questionNumberLbl.topAnchor.constraint(equalTo: timerLbl.bottomAnchor, constant: constraint).isActive = true
        questionNumberLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        questionNumberLbl.textAlignment = .left
        questionNumberLbl.frame.size.height = 40
        
        questionTitleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        questionTitleLbl.topAnchor.constraint(equalTo: questionNumberLbl.bottomAnchor, constant: constraint).isActive = true
        questionTitleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        questionTitleLbl.textAlignment = .left
        questionTitleLbl.frame.size.height = 30
        
        questionLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        questionLbl.topAnchor.constraint(equalTo: questionTitleLbl.bottomAnchor, constant: constraint).isActive = true
        questionLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        questionLbl.textAlignment = .left
        
        getHintBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constraint * 2).isActive = true
        getHintBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        getHintBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        
        answer3Btn.bottomAnchor.constraint(equalTo: getHintBtn.topAnchor, constant: -constraint * 2).isActive = true
        answer3Btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        answer3Btn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        
        answer2Btn.bottomAnchor.constraint(equalTo: answer3Btn.topAnchor, constant: -constraint).isActive = true
        answer2Btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        answer2Btn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        
        answer1Btn.bottomAnchor.constraint(equalTo: answer2Btn.topAnchor, constant: -constraint).isActive = true
        answer1Btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        answer1Btn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
    }
}

extension QuestionsVC {
    func requestNetworkData() {
        let net = Network()
        guard let file = net.readLocalFile(forName: "questions") else { return }
        questions = net.parse(jsonData: file)
        
//        let urlString = "https://api.jsonbin.io/v3/b/62cb813ef023111c70717c3a"
//
//        net.loadJson(fromURLString: urlString) { (result) in
//            switch result {
//            case .success(let data):
//                self.questions = net.parse(jsonData: data)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}

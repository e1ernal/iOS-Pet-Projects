//
//  QuestionsVC.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 09.07.2022.
//

import Foundation
import UIKit

class QuestionsVC: UIViewController, Playable {
    
    /// Playable protocol
    var game = GameEntities()
    
    lazy var timerLbl          = RegularLabel()
    lazy var questionNumberLbl = TitleLabel()
    lazy var questionTitleLbl  = SubtitleLabel()
    lazy var questionLbl       = RegularLabel()
    
    lazy var answer1Btn = RegularButton()
    lazy var answer2Btn = RegularButton()
    lazy var answer3Btn = RegularButton()
    lazy var getHintBtn = FurtherButton()
    
    /// Get from CoreData
    var questions: [Question] = []
    var time: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// JSON request
        requestNetworkData()
        game.newGame()
        makeUI()
        showNextQuestion()
    }
    
    func showNextQuestion() {
        
        guard prepared() else {
            /// Go to ScoreVC
            let nextVC: ScoreVC = ScoreVC()
            navigationController?.pushViewController(nextVC, animated: true)
            print("SCORE: \(game.score)")
            print("Game ower.")
            game.stopGame()
            return
        }
        
        game.stopTimer()
        
        time = game.timePerQuestion
        defaultColors()
        game.timer = Timer.scheduledTimer(timeInterval: 1,
                                                target: self,
                                              selector: #selector(updateTimer),
                                              userInfo: nil,
                                               repeats: true)
        
        let randAnswer = [0, 1, 2].shuffled()
        let answers = questions[game.currentQuestion].answers
        
        timerLbl.text = " : "
        questionNumberLbl.text = "Вопрос №\(game.currentQuestion + 1)"
        questionTitleLbl.text = "<\(questions[game.currentQuestion].title)>"
        questionLbl.text = questions[game.currentQuestion].question
        
        answer1Btn.setTitle(answers[randAnswer[0]], for: .normal)
        answer2Btn.setTitle(answers[randAnswer[1]], for: .normal)
        answer3Btn.setTitle(answers[randAnswer[2]], for: .normal)
        getHintBtn.setTitle("Использовать подсказку", for: .normal)
        
    }
    
    func prepared() -> Bool {
        game.currentQuestion += 1
        guard !questions.isEmpty else { return false }
        guard game.currentQuestion < questions.count else { return false }
        return true
    }
    /// Action every time interval
    @objc func updateTimer() {
        /// Update Label
        if time >= 0 {
            switch time {
                case 41...  : timerLbl.textColor = .systemGreen
                case 21...40: timerLbl.textColor = .systemOrange
                case 0...20 : timerLbl.textColor = .systemRed
                default     : timerLbl.textColor = .white
            }
            
            let minutes = String(format: "%02d", time / 60)
            let seconds = String(format: "%02d", time % 60)
            timerLbl.text = minutes + " : " + seconds
            time -= 1
        } else if time < 0 {
            showNextQuestion()
        }
    }
    
    @objc func answerPressed(sender: UIButton) {
        
        let answer = questions[game.currentQuestion].answer
        
        if sender.titleLabel?.text == answer {
            print("\(game.currentQuestion): [+] Ответ верный.")
            game.score += game.plusPoint
        } else {
            print("\(game.currentQuestion):[-] Ответ неверный.")
        }
        showNextQuestion()
    }
    
    @objc func getHintAction(sender: UIButton) {
        /// Open HintVC
    }
}

extension QuestionsVC {
    
    func makeUI() {
        
        let constraint = Constraints.basic.rawValue
        
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
        
        answer1Btn.addTarget(self, action: #selector(answerPressed), for: .touchUpInside)
        answer2Btn.addTarget(self, action: #selector(answerPressed), for: .touchUpInside)
        answer3Btn.addTarget(self, action: #selector(answerPressed), for: .touchUpInside)
        getHintBtn.addTarget(self, action: #selector(getHintAction), for: .touchUpInside)
    }
    
    func defaultColors() {
        timerLbl.textColor = .white
        
        answer1Btn.setDefaultColor()
        answer2Btn.setDefaultColor()
        answer3Btn.setDefaultColor()
        getHintBtn.setDefaultColor()
    }
}

extension QuestionsVC {
    func requestNetworkData() {
        let net = Network()
        guard let file = net.readLocalFile(forName: "questions") else { return }
        questions = net.parse(jsonData: file)
        
        /* Work with URL */
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

//
//  QuestionsVC.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 09.07.2022.
//

import Foundation
import UIKit

class QuestionsVC: UIViewController, Playable {
    
    // MARK: Playable protocol
    var game = GameEntities()
    
    lazy var timerLbl          = TitleLabel()
    lazy var questionNumberLbl = TitleLabel()
    lazy var questionTitleLbl  = SubtitleLabel()
    lazy var questionLbl       = RegularLabel()
    
    lazy var answer1Btn = RegularButton()
    lazy var answer2Btn = RegularButton()
    lazy var answer3Btn = RegularButton()
    lazy var getHintBtn = RegularButton()
    lazy var pageControl = UIPageControl(frame: .zero)
    
    var questions: [Question] = []
    var time: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestNetworkData()
        makeUI()
        game.newGame()
        showNextQuestion()
    }
    
    func showNextQuestion() {
        // MARK: Show Score at the end of questions
        guard prepared() else {
            ModelRequest().appendItem(score: game.score,
                                       name: game.name,
                                       time: game.time,
                                       date: game.date,
                                   maxScore: questions.count * game.plusPoint,
                               allQuestions: questions.count,
                             rightQuestions: game.questions)
            
            let nextVC: ResultVC = ResultVC()
            nextVC.score = game.score
            nextVC.time = game.time
            nextVC.maxScore = questions.count * game.plusPoint
            navigationController?.pushViewController(nextVC, animated: true)
            game.endGame()
            return
        }
        
        game.stopTimer()
        
        time = game.timePerQuestion
//        defaultColors()
        game.timer = Timer.scheduledTimer(timeInterval: 1,
                                                target: self,
                                              selector: #selector(updateTimer),
                                              userInfo: nil,
                                               repeats: true)
        
        let randAnswer = [0, 1, 2].shuffled()
        let answers = questions[game.currentQuestion].answers
        
        timerLbl.text = " "
        pageControl.currentPage = game.currentQuestion
        questionNumberLbl.text = "???????????? ???\(game.currentQuestion + 1)"
        questionTitleLbl.text = "<\(questions[game.currentQuestion].title)>"
        questionLbl.text = questions[game.currentQuestion].question
        questionLbl.numberOfLines = 0
        
        answer1Btn.setup(title: answers[randAnswer[0]])
        answer2Btn.setup(title: answers[randAnswer[1]])
        answer3Btn.setup(title: answers[randAnswer[2]])
        getHintBtn.setup(title: "???????????????????????? ??????????????????")
    }
    
    // MARK: Array out of bounds check
    func prepared() -> Bool {
        game.currentQuestion += 1
        guard !questions.isEmpty else { return false }
        guard game.currentQuestion < questions.count else { return false }
        return true
    }
    
    // MARK: Update timer every time interval
    @objc func updateTimer() {
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
            game.time += game.timePerQuestion - time
            showNextQuestion()
        }
    }
    
    @objc func answerPressed(sender: UIButton) {
        let answer = questions[game.currentQuestion].answer
        
        if sender.titleLabel?.text == answer {
            print("\(game.currentQuestion): [+] ?????????? ????????????.")
            game.score += game.plusPoint
            game.questions += 1
        } else {
            print("\(game.currentQuestion): [-] ?????????? ????????????????.")
        }
        game.time += game.timePerQuestion - time
        showNextQuestion()
    }
    
    // MARK: Open Hint View Contoller
    @objc func getHintAction(sender: UIButton) {
    }
}

extension QuestionsVC {
    
    func makeUI() {
        let constraint = Constraints.basic.rawValue
        self.view.backgroundColor = .black
        
        self.view.addSubview(pageControl)
        self.view.addSubview(timerLbl)
        self.view.addSubview(questionNumberLbl)
        self.view.addSubview(questionTitleLbl)
        self.view.addSubview(questionLbl)
        self.view.addSubview(answer1Btn)
        self.view.addSubview(answer2Btn)
        self.view.addSubview(answer3Btn)
        self.view.addSubview(getHintBtn)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constraint).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        pageControl.numberOfPages = questions.count
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .systemGray6
        
        timerLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        timerLbl.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: constraint).isActive = true
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
    
//    func defaultColors() {
//        timerLbl.textColor = .white
//
//        answer1Btn.extraSetup()
//        answer2Btn.extraSetup()
//        answer3Btn.extraSetup()
//        getHintBtn.extraSetup()
//    }
}

extension QuestionsVC {
    func requestNetworkData() {
        let net = Network()
        
        // MARK: Request to local file
        guard let file = net.readLocalFile(forName: "questions") else { return }
        questions = net.parse(jsonData: file)
        
        // MARK: Request by URL
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

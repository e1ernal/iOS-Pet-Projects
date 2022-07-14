//
//  Game.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 11.07.2022.
//

import Foundation


protocol Playable: AnyObject {
    var game: GameEntities { get set }
//    func help()
}

class GameEntities {
    
    // MARK: Score entities
    var name: String = "Player name"
    var date: Date = Date()
    var time: Int = 3600
    var score: Int = 0
    
    // MARK: Game Service
    var currentQuestion: Int = -1
    var timePerQuestion: Int = 0 // seconds
    var timer: Timer?
    
    // MARK: Work with answers
    var plusPoint: Int = 10
    var minusPointByHint_50_50: Int = 5
    var minusPointByHint_RightAnswer: Int = 8
    
    func newGame() {
        name = "Player name"
        score = 0
        timePerQuestion = 90
        currentQuestion = -1
        time = 0
    }
    
    func endGame() {
        score = 0
        timePerQuestion = 0
        stopTimer()
        time = 3600
        name = "Player name"
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

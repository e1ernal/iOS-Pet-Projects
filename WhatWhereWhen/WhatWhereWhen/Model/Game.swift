//
//  Game.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 11.07.2022.
//

import Foundation

class GameEntities {
    var score: Int = 0
    var timePerQuestion: Int = 0 // seconds
    var timer: Timer?
    var currentQuestion: Int = -1
    
    var plusPoint: Int = 10
    var minusPointByHint_50_50: Int = 5
    var minusPointByHint_RightAnswer: Int = 8
    
    func newGame() {
        score = 0
        timePerQuestion = 90
        currentQuestion = -1
    }
    
    func stopGame() {
        score = 0
        timePerQuestion = 0
        stopTimer()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

protocol Playable: AnyObject {
    var game: GameEntities { get set }
//    func help()
}

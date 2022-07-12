//
//  Model.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 11.07.2022.
//

import Foundation

struct Question: Codable {
    let id: Int
    let title: String
    let question: String
    let answers: [String]
    let answer: String
}

struct Score {
    let name: String
    let date: Date
    let score: Int
    let time: Int
    let totalScore: Int
}

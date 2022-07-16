//
//  CustomTableView.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 09.07.2022.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var squareView = UIView()
    var perсеntLabel = LightLabel()
    
    var nameLabel = LightLabel()
    
    var scoreTitle = SmallLabel()
    var score = LightLabel()
    
    var questionsTitle = SmallLabel()
    var questions = LightLabel()
    
    var timeTitle = SmallLabel()
    var time = LightLabel()
    
    var dateTitle = SmallLabel()
    var date = LightLabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let constraint = Constraints.cell.rawValue
        self.backgroundColor = .systemGray6
        
        squareView.translatesAutoresizingMaskIntoConstraints  = false
        perсеntLabel.translatesAutoresizingMaskIntoConstraints  = false
        nameLabel.translatesAutoresizingMaskIntoConstraints  = false
        scoreTitle.translatesAutoresizingMaskIntoConstraints  = false
        score.translatesAutoresizingMaskIntoConstraints  = false
        questionsTitle.translatesAutoresizingMaskIntoConstraints  = false
        questions.translatesAutoresizingMaskIntoConstraints  = false
        timeTitle.translatesAutoresizingMaskIntoConstraints  = false
        time.translatesAutoresizingMaskIntoConstraints  = false
        dateTitle.translatesAutoresizingMaskIntoConstraints  = false
        date.translatesAutoresizingMaskIntoConstraints  = false
        
        squareView.addSubview(perсеntLabel)
        
        contentView.addSubview(squareView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(scoreTitle)
        contentView.addSubview(score)
        contentView.addSubview(questionsTitle)
        contentView.addSubview(questions)
        contentView.addSubview(timeTitle)
        contentView.addSubview(time)
        contentView.addSubview(dateTitle)
        contentView.addSubview(date)
                           
        squareView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        squareView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constraint).isActive = true
        squareView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7).isActive = true
        squareView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7).isActive = true
        squareView.layer.cornerRadius = 10
        
        perсеntLabel.centerXAnchor.constraint(equalTo: squareView.centerXAnchor).isActive = true
        perсеntLabel.centerYAnchor.constraint(equalTo: squareView.centerYAnchor).isActive = true
        perсеntLabel.font = UIFont.systemFont(ofSize: TextSize.light.rawValue, weight: TextWeight.title.getWeight())
        
        nameLabel.leadingAnchor.constraint(equalTo: squareView.trailingAnchor, constant: constraint).isActive = true
        nameLabel.topAnchor.constraint(equalTo: squareView.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constraint).isActive = true
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: TextSize.light.rawValue, weight: TextWeight.title.getWeight())

        scoreTitle.leadingAnchor.constraint(equalTo: squareView.trailingAnchor, constant: constraint).isActive = true
        scoreTitle.centerYAnchor.constraint(equalTo: squareView.centerYAnchor).isActive = true
        scoreTitle.text = "Очки:"
        scoreTitle.textAlignment = .left
        
        score.leadingAnchor.constraint(equalTo: scoreTitle.trailingAnchor).isActive = true
        score.centerYAnchor.constraint(equalTo: scoreTitle.centerYAnchor).isActive = true
        score.trailingAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        score.textAlignment = .right
        
        questionsTitle.leadingAnchor.constraint(equalTo: squareView.trailingAnchor, constant: constraint).isActive = true
        questionsTitle.bottomAnchor.constraint(equalTo: squareView.bottomAnchor).isActive = true
        questionsTitle.textAlignment = .left
        questionsTitle.text = "Вопросы:"
        
        questions.leadingAnchor.constraint(equalTo: questionsTitle.trailingAnchor).isActive = true
        questions.centerYAnchor.constraint(equalTo: questionsTitle.centerYAnchor).isActive = true
        questions.trailingAnchor.constraint(equalTo: score.trailingAnchor).isActive = true
        questions.textAlignment = .right
        
        timeTitle.leadingAnchor.constraint(equalTo: score.trailingAnchor, constant: constraint).isActive = true
        timeTitle.centerYAnchor.constraint(equalTo: score.centerYAnchor).isActive = true
        timeTitle.textAlignment = .left
        timeTitle.text = "Время:"
        
        time.centerYAnchor.constraint(equalTo: timeTitle.centerYAnchor).isActive = true
        time.leadingAnchor.constraint(equalTo: timeTitle.trailingAnchor).isActive = true
        time.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constraint).isActive = true
        time.textAlignment = .right

        dateTitle.centerYAnchor.constraint(equalTo: questions.centerYAnchor).isActive = true
        dateTitle.leadingAnchor.constraint(equalTo: questions.trailingAnchor, constant: constraint).isActive = true
        dateTitle.textAlignment = .left
        dateTitle.text = "Дата:"
        
        date.centerYAnchor.constraint(equalTo: dateTitle.centerYAnchor).isActive = true
        date.leadingAnchor.constraint(equalTo: dateTitle.trailingAnchor).isActive = true
        date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constraint).isActive = true
        date.textAlignment = .right
    }
}

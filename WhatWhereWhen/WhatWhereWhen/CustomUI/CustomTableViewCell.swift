//
//  CustomTableView.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 09.07.2022.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {

    var rewardLabel = RewardLabel()
    var attemptLabel = LightLabel()
    var scoreLabel = LightLabel()
    
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
        let constraint = Constraints.basic.rawValue
        
        rewardLabel.translatesAutoresizingMaskIntoConstraints  = false
        attemptLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints   = false
        
        contentView.addSubview(rewardLabel)
        contentView.addSubview(attemptLabel)
        contentView.addSubview(scoreLabel)
        
        rewardLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constraint).isActive = true
        rewardLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constraint).isActive = true
        rewardLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -constraint).isActive = true
        rewardLabel.widthAnchor.constraint(equalToConstant: constraint).isActive = true
        
        
        attemptLabel.leadingAnchor.constraint(equalTo: rewardLabel.trailingAnchor, constant: constraint).isActive = true
        attemptLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constraint).isActive = true
        attemptLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -constraint).isActive = true
        attemptLabel.widthAnchor.constraint(equalToConstant: constraint * 4).isActive = true
        
        scoreLabel.leadingAnchor.constraint(equalTo: attemptLabel.trailingAnchor, constant: constraint).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constraint).isActive = true
        scoreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -constraint).isActive = true
        scoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constraint).isActive = true
    }
    
}

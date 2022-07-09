//
//  Labels.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 09.07.2022.
//

import Foundation
import UIKit

class CustomLabels: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.numberOfLines = 0
        self.textAlignment = .center
        self.textColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        setFont()
    }
    
    func setFont() {}
}

class TitleLabel: CustomLabels {
    override func setFont() {
        self.font = UIFont.systemFont(ofSize: TextSize.title.rawValue, weight: TextWeight.title.getWeight())
    }
}

class SubtitleLabel: CustomLabels {
    override func setFont() {
        self.font = UIFont.systemFont(ofSize: TextSize.subtitle.rawValue, weight: TextWeight.subtitle.getWeight())
    }
}

class RegularLabel: CustomLabels {
    override func setFont() {
        self.font = UIFont.systemFont(ofSize: TextSize.regular.rawValue, weight: TextWeight.regular.getWeight())
    }
}

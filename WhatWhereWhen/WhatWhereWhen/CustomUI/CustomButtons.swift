//
//  RegularButton.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 09.07.2022.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        self.titleLabel?.numberOfLines = 0
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.height / 2.0
        self.translatesAutoresizingMaskIntoConstraints = false
        setColor()
    }
    
    func setColor() {}
}

class RegularButton: CustomButton {
    
    override func setColor() {
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = .systemBlue
    }
}

class HintButton: CustomButton {
    
    override func setColor() {
        self.setTitleColor(UIColor.systemBlue, for: .normal)
        self.backgroundColor = .systemGray6
    }
}

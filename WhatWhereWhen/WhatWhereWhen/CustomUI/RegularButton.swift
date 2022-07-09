//
//  RegularButton.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 09.07.2022.
//

import Foundation
import UIKit

class RegularButton: UIButton {
    
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
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.height / 2.0
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = .systemBlue
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

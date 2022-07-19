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
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.height / 3.0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

class RegularButton: CustomButton {
    func setup(title: String) {
        self.setTitle(title, for: .normal)
        self.heightAnchor.constraint(equalToConstant: 1.5 * Constraints.height.rawValue).isActive = true
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = .systemBlue
    }
}

class ImageButton: CustomButton {
    func setup(image name: String) {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let closeImage = UIImage(systemName: name, withConfiguration: symbolConfiguration)
        self.setImage(closeImage, for: .normal)
        self.imageView?.contentMode = .scaleAspectFill
        self.heightAnchor.constraint(equalToConstant: 1.5 * Constraints.height.rawValue).isActive = true
        self.widthAnchor.constraint(equalToConstant: 1.5 * Constraints.height.rawValue).isActive = true
    }
}

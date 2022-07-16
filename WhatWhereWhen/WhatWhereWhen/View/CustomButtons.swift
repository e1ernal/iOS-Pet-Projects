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
        self.layer.cornerRadius = self.frame.size.height / 3.0
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 1.5 * Constraints.height.rawValue).isActive = true
        extraSetup()
    }
    
    func extraSetup() {}
}

class RegularButton: CustomButton {
    override func extraSetup() {
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = .systemBlue
    }
}

class FurtherButton: CustomButton {
    override func extraSetup() {
        self.setTitleColor(UIColor.systemBlue, for: .normal)
        self.backgroundColor = .systemGray6
        self.titleLabel?.textColor = .white
    }
}

class CloseButton: CustomButton {
    override func extraSetup() {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let closeImage = UIImage(systemName: "xmark.circle", withConfiguration: symbolConfiguration)
        self.setImage(closeImage, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.heightAnchor.constraint(equalToConstant: Constraints.height.rawValue).isActive = true
        self.widthAnchor.constraint(equalToConstant: Constraints.height.rawValue).isActive = true
    }
}

class SortButton: CustomButton {
    override func extraSetup() {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let closeImage = UIImage(systemName: "arrow.up.arrow.down.circle", withConfiguration: symbolConfiguration)
        self.setImage(closeImage, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.heightAnchor.constraint(equalToConstant: Constraints.height.rawValue).isActive = true
        self.widthAnchor.constraint(equalToConstant: Constraints.height.rawValue).isActive = true
    }
}

class SettingsButton: CustomButton {
    override func extraSetup() {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let closeImage = UIImage(systemName: "gear", withConfiguration: symbolConfiguration)
        self.setImage(closeImage, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.backgroundColor = .systemBlue
        self.tintColor = .white
        self.heightAnchor.constraint(equalToConstant: 1.5 * Constraints.height.rawValue).isActive = true
        self.widthAnchor.constraint(equalToConstant: 1.5 * Constraints.height.rawValue).isActive = true
    }
}

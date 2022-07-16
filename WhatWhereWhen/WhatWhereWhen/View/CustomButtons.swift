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
    }
}

class ImageButton: CustomButton {
    func setupImage(image: String) {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let closeImage = UIImage(systemName: image, withConfiguration: symbolConfiguration)
        self.setImage(closeImage, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.heightAnchor.constraint(equalToConstant: Constraints.height.rawValue).isActive = true
        self.widthAnchor.constraint(equalToConstant: Constraints.height.rawValue).isActive = true
    }
}

class CloseButton: ImageButton {
    override func extraSetup() {
        setupImage(image: "xmark.circle")
    }
}

class SortButton: ImageButton {
    override func extraSetup() {
        setupImage(image: "arrow.up.arrow.down")
    }
}

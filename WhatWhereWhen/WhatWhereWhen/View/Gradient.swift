//
//  GradientAnimation.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 12.07.2022.
//

import Foundation
import UIKit

protocol Gradientable {
    func setGradientBackground(frame: CGRect)
}

// MARK: Not used in the current version
// Intended to be used as a background
class Gradient: CAGradientLayer {
    let gradient = CAGradientLayer()
    var currentGradient: Int = 0
    var gradientSet = [[CGColor]]()
    let durationTime: Int = 5
    
    let color1 = UIColor.cyan.withAlphaComponent(0.1).cgColor
    let color2 = UIColor.systemBlue.withAlphaComponent(0.1).cgColor
    let color3 = UIColor.black.withAlphaComponent(1).cgColor
    let color4 = UIColor.purple.withAlphaComponent(0.1).cgColor
    
    init(frame: CGRect) {
        super.init()
        
        gradientSet.append([color1, color3])
        gradientSet.append([color3, color2])
        gradientSet.append([color4, color3])
        gradientSet.append([color4, color3])
        
        gradient.frame = frame
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.drawsAsynchronously = true

        _ = Timer.scheduledTimer(timeInterval: 4 * 3,
                                       target: self,
                                     selector: #selector(animateGradient),
                                     userInfo: nil,
                                      repeats: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func animateGradient() {
        currentGradient = (currentGradient + 1) % gradientSet.count
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 3
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = .forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradient.add(gradientChangeAnimation, forKey: "colorChange")
    }
}

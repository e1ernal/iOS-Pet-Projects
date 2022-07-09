//
//  UISettings.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 09.07.2022.
//

import Foundation
import UIKit

enum TextWeight {
    case title
    case subtitle
    case regular
    case light
    
    func getWeight() -> UIFont.Weight {
        switch self {
        case .title:
            return UIFont.Weight.semibold
        case .subtitle:
            return UIFont.Weight.medium
        case .regular:
            return UIFont.Weight.regular
        case .light:
            return UIFont.Weight.light
        }
    }
}

enum TextSize: CGFloat {
    case title    = 30
    case subtitle = 25
    case regular  = 20
    case small    = 15
}

enum Constraints: CGFloat {
    case basic  = 20
    case height = 30
}

enum Reward: String {
    case first  = "🥇"
    case second = "🥈"
    case third  = "🥉"
    case other  = ""
}

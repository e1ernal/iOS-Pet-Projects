//
//  Animations.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 14.07.2022.
//

import Foundation
import UIKit

extension UIView {
    static func animate(with animator: Animator, animations: @escaping () -> (), completion: ((Bool) -> ())? = nil) {
        animator.perform(animations, completion)
    }
}

struct Animator {
    typealias Animations = () -> ()
    typealias Completion = (Bool) -> ()
    
    let perform: (@escaping Animations, Completion?) -> ()
}

extension Animator {
    static let popup = Animator { (animations, completion) in
        UIView.animate(withDuration: 1,
                              delay: 0,
             usingSpringWithDamping: 0.7,
              initialSpringVelocity: 1,
                            options: .curveEaseIn,
                         animations: animations,
                         completion: completion
        )
    }
}


extension UIViewController {
     @objc func dismissKeyboard() {
         self.view.endEditing(true)
     }
 }

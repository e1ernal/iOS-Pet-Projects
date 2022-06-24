//
//  SimpleMath.swift
//  FloatingpointCalculator
//
//  Created by Dmitry Smirnykh on 22.06.2022.
//

import Foundation

enum Operation: String {
    case nullable = "Nothing"
    case add      = "+"
    case subtract = "-"
    case multiply = "x"
    case divide   = ":"
}

enum ErrorMessage: String {
    case tooLong           = "Number has max lenght"
    case divideFall        = "Division error"
    case noValue           = "No value: input a number"
    case unrecognisedError = "Error"
    case hideMe            = ""
    case dotError          = "The dot is already exist"
}

struct SimpleMath {
    var numberOnDisplay: String     = ""
    var leftHandSideValue: String   = ""
    var rightHandSideValue: String  = ""
    var result: String              = ""
    var currentOperation: Operation = .nullable
    var error: ErrorMessage         = .hideMe
    
    mutating func pressedNumber(number: Int) {
        error = .hideMe
        if isNormalLenght(number: numberOnDisplay) {
            numberOnDisplay += String(number)
        }
    }
    
    mutating func dot() {
        error = .hideMe
        if numberOnDisplay.contains(".") {
            error = .dotError
        } else if isNormalLenght(number: numberOnDisplay) {
            if numberOnDisplay == "" { numberOnDisplay = "0" }
            numberOnDisplay += "."
        }
    }
    
    mutating func clear() {
        numberOnDisplay    = ""
        leftHandSideValue  = ""
        rightHandSideValue = ""
        result             = ""
        numberOnDisplay    = ""
        currentOperation   = .nullable
        error              = .hideMe
    }
    
    mutating func add(leftValue: Float, rightValue: Float) {
        result = makeStringWithOutZero(number: leftValue + rightValue)
    }
    
    mutating func substract(leftValue: Float, rightValue: Float) {
        result = makeStringWithOutZero(number: leftValue - rightValue)
    }
    
    mutating func multiply(leftValue: Float, rightValue: Float) {
        result = makeStringWithOutZero(number: leftValue * rightValue)
    }
    
    mutating func divide(leftValue: Float, rightValue: Float) {
        if rightValue != 0 {
            result = makeStringWithOutZero(number: leftValue / rightValue)
        } else {
            clear()
            error = .divideFall
        }
    }
    
    mutating func operation(op: Operation) {
        error = .hideMe
        if numberOnDisplay != "" {
            if currentOperation == .nullable {
                leftHandSideValue = numberOnDisplay
                numberOnDisplay   = ""
                result            = ""
                currentOperation  = op
            } else {
                
                rightHandSideValue = numberOnDisplay
                let operands = makeFloat(l: leftHandSideValue, r: rightHandSideValue)
                
                switch currentOperation {
                    case .add:
                        add(leftValue: operands.l, rightValue: operands.r)
                    case .subtract:
                        substract(leftValue: operands.l, rightValue: operands.r)
                    case .multiply:
                        multiply(leftValue: operands.l, rightValue: operands.r)
                    case .divide:
                        divide(leftValue: operands.l, rightValue: operands.r)
                    default:
                        error = .unrecognisedError
                }
                if isNormalLenght(number: result) {
                    leftHandSideValue  = result
                    numberOnDisplay    = result
                    rightHandSideValue = ""
                    currentOperation   = .nullable
                } else {
                    clear()
                    error = .tooLong
                }
            }
        } else { error = .noValue }
    }
}

extension SimpleMath {
    
    mutating func makeFloat(l: String, r: String) -> (l: Float, r: Float) {
        func makeAFloat(a: String) -> Float {
            if let a = Float(a) { return a }
            else {
                error = .unrecognisedError
                return 0
            }
        }
        return (makeAFloat(a: l), makeAFloat(a: r))
    }
    
    func makeStringWithOutZero(number: Float) -> String {
        if number == Float(Int(number)) { return String(Int(number)) }
        else { return String(number) }
//        return number.truncatingRemainder(dividingBy: 1)
    }
    
    mutating func isNormalLenght(number: String) -> Bool {
        if number.count >= 9 {
            error = .tooLong
            return false
        } else { return true }
    }
}

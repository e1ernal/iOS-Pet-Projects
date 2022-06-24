//
//  ViewController.swift
//  FloatingpointCalculator
//
//  Created by Dmitry Smirnykh on 21.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var clearBtn: UIButton!
    @IBOutlet var divideBtn: UIButton!
    @IBOutlet var multiplyBtn: UIButton!
    @IBOutlet var minusBtn: UIButton!
    @IBOutlet var plusBtn: UIButton!
    @IBOutlet var equalBtn: UIButton!
    @IBOutlet var pointBtn: UIButton!
    
    @IBOutlet var Btn7: UIButton!
    @IBOutlet var Btn8: UIButton!
    @IBOutlet var Btn9: UIButton!
    @IBOutlet var Btn4: UIButton!
    @IBOutlet var Btn5: UIButton!
    @IBOutlet var Btn6: UIButton!
    @IBOutlet var Btn1: UIButton!
    @IBOutlet var Btn2: UIButton!
    @IBOutlet var Btn3: UIButton!
    @IBOutlet var Btn0: UIButton!
    
    @IBOutlet var digitalDisplay: UILabel!
    @IBOutlet var errorLabel: UILabel!
    
    var math = SimpleMath()

    @IBAction func pressedNumber(_ sender: UIButton) {
        math.pressedNumber(number: sender.tag)
        updateErrorLabel()
        digitalDisplay.text = math.numberOnDisplay
    }
    
    @IBAction func pressedDot(_ sender: UIButton) {
        math.dot()
        updateErrorLabel()
        digitalDisplay.text = math.numberOnDisplay
    }
    
    @IBAction func pressedClear(_ sender: UIButton) {
        math.clear()
        digitalDisplay.text = "0"
        updateErrorLabel()
    }
    
    @IBAction func pressedEqual(_ sender: UIButton) {
        calculate(math.currentOperation)
    }
    
    @IBAction func pressedPlus(_ sender: UIButton) {
        calculate(.add)
    }
    
    @IBAction func pressedMinus(_ sender: UIButton) {
        calculate(.subtract)
    }
    
    @IBAction func pressedMult(_ sender: UIButton) {
        calculate(.multiply)
    }
    
    @IBAction func pressedDivide(_ sender: UIButton) {
        calculate(.divide)
    }
}

extension ViewController {

    override func viewDidLoad() {
        errorLabel.text = ""
        let buttons = [Btn1, Btn2, Btn3, Btn4, Btn5, Btn6, Btn7, Btn8, Btn9, Btn0, clearBtn, divideBtn, multiplyBtn, minusBtn, plusBtn, equalBtn, pointBtn]
        makeRoundButtons(buttons: buttons)
    }
    
    func updateErrorLabel() {
        errorLabel.text = math.error.rawValue
        if math.error != .hideMe {
            digitalDisplay.text = "0"
        }
    }
    
    func calculate(_ op: Operation) {
        math.operation(op: op)
        digitalDisplay.text = math.result
        updateErrorLabel()
    }
    
    func makeRoundButtons(buttons: [UIButton?]) {
        for button in buttons {
            button?.layer.cornerRadius = (button?.layer.bounds.size.height ?? 10) * 0.5
        }
    }
}

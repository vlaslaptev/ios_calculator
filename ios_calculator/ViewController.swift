//
//  ViewController.swift
//  ios_calculator
//
//  Created by v.laptev on 24.03.2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var resultLabel: UILabel!
    
    var isStartTyping = true
    var firstOperand: Double = 0
    var isSelectOperator = false
    var isPressOperator = false
    var operatorType = ""
    var operatorButton : UIButton? = nil;
    var currentInput: Double {
        get {
            return Double(resultLabel.text!)!
        }
        set{
            if (floor(newValue) == newValue) {
                resultLabel.text = "\(Int64(newValue))"
            } else {
                resultLabel.text = "\(newValue)"
            }
            isStartTyping = true
        }
    }

    @IBAction func pressClearAll(_ sender: UIButton) {
        currentInput = Double(0)
        clearAllVarAfterPrintResult(sender: sender)
    }

    @IBAction func pressBackspace(_ sender: UIButton) {
        let currentText = resultLabel.text ?? ""
        if (isStartTyping) {
            resultLabel.text = "0"
            return
        }
        if (currentText == "" || currentText.count == 1) {
            resultLabel.text = "0"
            isStartTyping = true
        } else {
            resultLabel.text = String (currentText.dropLast())
            if (resultLabel.text! == "0") {
                isStartTyping = true
            }
        }
        isSelectOperator = false
    }
    
    @IBAction func pressZero(_ sender: UIButton) {
        if (isStartTyping) {
            if (isPressOperator) {
                pressNumber(sender)
            }
        } else {
            pressNumber(sender)
        }
    }
    
    @IBAction func pressComma(_ sender: UIButton) {
        if (resultLabel.text!.range(of:".") == nil) {
            resultLabel.text = resultLabel.text! + "."
            isStartTyping = false
        }
    }

    @IBAction func pressNumber(_ sender: UIButton) {
        let number = sender.currentTitle!
        let currentText = resultLabel.text ?? ""
        if (currentText.count < 25) {
            if (isStartTyping || currentText == "0") {
                resultLabel.text = number
                isStartTyping = false
            } else {
                resultLabel.text = resultLabel.text! + number
            }
        }
        isSelectOperator = false
    }

    @IBAction func pressEqual(_ sender: UIButton) {
        if (isPressOperator) {
            let result: Double = applyOperator(operatorType: operatorType, firstOperand: firstOperand, secondOperand: currentInput)
            currentInput = result
            clearAllVarAfterPrintResult(sender: sender)
        }
    }

    @IBAction func pressUnaryOperator(_ sender: UIButton) {
        currentInput = applyUnaryOperator(unaryOperatorType: sender.currentTitle!)
        clearAllVarAfterPrintResult(sender: sender)
    }

    @IBAction func pressOperator(_ sender: UIButton) {
        if (!isSelectOperator || operatorType != sender.currentTitle) {
            if (isPressOperator && !isSelectOperator) {
                let result: Double = applyOperator(operatorType: operatorType, firstOperand: firstOperand, secondOperand: currentInput)
                currentInput = result
                firstOperand = result
                operatorType = sender.currentTitle!
                isSelectOperator = false
                changeOrClearBackgroungOperatorButton(button: sender)
            } else {
                isSelectOperator = true
                firstOperand = currentInput
                isStartTyping = true
                isPressOperator = true
                operatorType = sender.currentTitle!
                changeOrClearBackgroungOperatorButton(button: sender)
            }
        }
    }

    func changeOrClearBackgroungOperatorButton(button: UIButton) {
        if (["+", "-", "✕", "÷"].contains(button.currentTitle!)) {
            operatorButton?.backgroundColor = UIColor.white
            operatorButton = button
            button.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.05)
        } else {
            operatorButton?.backgroundColor = UIColor.white
        }
    }

    func applyOperator(operatorType: String,
                       firstOperand: Double,
                       secondOperand: Double) -> Double {
        var result: Double = 0
        switch operatorType {
        case "+":
            result = firstOperand + secondOperand
            break
        case "-":
            result = firstOperand - secondOperand
            break
        case "✕":
            result = firstOperand * secondOperand
            break
        case "÷":
            result = firstOperand / secondOperand
            break
        default:
            break
        }
        return result;
    }

    func clearAllVarAfterPrintResult(sender: UIButton) {
        isPressOperator = false
        firstOperand = 0
        isStartTyping = true
        isSelectOperator = false
        changeOrClearBackgroungOperatorButton(button: sender)
    }

    func applyUnaryOperator(unaryOperatorType: String) -> Double {
        var result = currentInput
        switch unaryOperatorType {
        case "X²":
            result = result * result
            break
        case "X³":
            result = result * result * result
            break
        case "√":
            result = result.squareRoot()
            break
        case "%":
            result = result / 100
            break
        case "+\\-":
            result = -result
            break
        default:
            break
        }
        return result
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


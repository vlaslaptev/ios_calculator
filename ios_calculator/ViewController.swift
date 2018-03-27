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
    
    @IBAction func pressNumber(_ sender: UIButton) {
        let number = sender.currentTitle!
        let currentText = resultLabel.text ?? ""
        
        if (number == "<––") {
            if (currentText == "" || currentText.count == 1) {
                resultLabel.text = "0"
                isStartTyping = true
            } else {
                resultLabel.text = String (currentText.dropLast())
            }
            isSelectOperator = false
            return
        }
        
        if ((number == "0" || number == "000") && isStartTyping) {
            isSelectOperator = false
            return
        }
        
        if (currentText.count < 25) {
            if (isStartTyping) {
                resultLabel.text = number
                isStartTyping = false
            } else {
                resultLabel.text = resultLabel.text! + number
            }
            isSelectOperator = false
        }
    }
    
    var firstOperand: Double = 0
    var currentInput: Double {
        get {
            return Double(resultLabel.text!)!
        }
        
        set{
            if (floor(newValue) == newValue) {
               resultLabel.text = "\(Int(newValue))"
            } else {
               resultLabel.text = "\(newValue)"
            }
            
            isStartTyping = true
        }
    }

    var isSelectOperator = false
    var isPressOperator = false
    var operatorType = ""
    var operatorButton : UIButton? = nil;
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
            break;
        }
        return result;
    }
    
    @IBAction func pressEqual(_ sender: UIButton) {
        if (isPressOperator) {
            let result: Double = applyOperator(operatorType: operatorType, firstOperand: firstOperand, secondOperand: currentInput)
            currentInput = result
            isPressOperator = false
            firstOperand = 0
            isStartTyping = true
            isSelectOperator = false
            changeOrClearBackgroungOperatorButton(button: sender)
        }
    }
    
    @IBAction func pressClearAll(_ sender: UIButton) {
        isStartTyping = true
        firstOperand = 0
        currentInput = Double(0)
        isPressOperator = false
        isSelectOperator = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


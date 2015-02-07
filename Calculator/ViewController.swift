//
//  ViewController.swift
//  Calculator
//
//  Created by Oscar Cortez on 1/30/15.
//  Copyright (c) 2015 XEngSoft. All rights reserved.
//

import UIKit // test

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var userEnteredDecimalPoint = false

    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
            println("digit = \(digit)")
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }

    @IBAction func decimalPoint(sender: UIButton) {
        let decimalCharacter = sender.currentTitle!
        if !userEnteredDecimalPoint && userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + decimalCharacter
            userEnteredDecimalPoint = true
        }
        
    }
    
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperation { sqrt($0) }
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }

    }
    
    func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
        
    }

    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        userEnteredDecimalPoint = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)" )
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = " \(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}


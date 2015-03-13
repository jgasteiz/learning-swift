//
//  ViewController.swift
//  Calculator
//
//  Created by Javi Manzano on 11/03/2015.
//  Copyright (c) 2015 Javi Manzano. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }

    @IBAction func appendFloatingPoint() {
        if userIsInTheMiddleOfTypingANumber
            && display.text!.rangeOfString(".") == nil
        {
            display.text = display.text! + "."
        }
    }

    @IBAction func appendPi() {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        display.text = "\(M_PI)"
        enter()
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
        case "sin": performOperation { sin($0) }
        case "cos": performOperation { cos($0) }
        case "π": performOperation { sqrt($0) }
        default:
        break
        }
    }

    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count > 1 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }

    func performOperation(operation: (Double) -> Double) {
        if operandStack.count > 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()

    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    @IBAction func clearAll() {
        display.text = "0"
        operandStack = Array<Double>()
        userIsInTheMiddleOfTypingANumber = false
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}


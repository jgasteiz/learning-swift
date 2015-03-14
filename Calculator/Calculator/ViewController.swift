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

    var brain = CalculatorBrain()
    
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
        userIsInTheMiddleOfTypingANumber = false
        displayValue = brain.pushOperand(M_PI)
    }


    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            displayValue = brain.performOperation(operation)
        }
    }


    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        displayValue = brain.pushOperand(displayValue!)
    }
    
    @IBAction func clearAll() {
        displayValue = nil
        userIsInTheMiddleOfTypingANumber = false
        brain.clearStack()
    }
    
    var displayValue: Double? {
        get {
            var numberFormatter = NSNumberFormatter()
            if let result = numberFormatter.numberFromString(display.text!) {
                return result.doubleValue
            }
            return 0
        }
        set {
            display.text = "\(newValue!)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}


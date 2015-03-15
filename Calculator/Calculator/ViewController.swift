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

    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            brain.pushOperand(displayValue!)
        }
        brain.pushOperator(sender.currentTitle!)
        userIsInTheMiddleOfTypingANumber = false
    }

    @IBAction func equals() {
        userIsInTheMiddleOfTypingANumber = false
        displayValue = brain.equals(displayValue!)
    }
    
    @IBAction func clearAll() {
        displayValue = nil
        userIsInTheMiddleOfTypingANumber = false
        brain.clearStack()
    }
    
    var displayValue: Double? {
        get {
            return NSNumberFormatter().numberFromString(display.text!)?.doubleValue
        }
        set {
            if newValue != nil {
                display.text = "\(newValue!)"
            } else {
                display.text = "0"
            }
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}


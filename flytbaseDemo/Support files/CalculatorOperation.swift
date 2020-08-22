//
//  CalculatorOperation.swift
//  flytbaseDemo
//
//  Created by vaibhav bhosale on 20/08/20.
//  Copyright © 2020 VB. All rights reserved.
//

import Foundation

protocol CountOnMeDelegate: class {
    func updateCal(strCalulation:String)
    func updateOutput(strOutput:String)
}

precedencegroup ExponentialPrecedence {
    lowerThan: MultiplicationPrecedence
    higherThan: AdditionPrecedence
    associativity: left
    assignment: false
}

infix operator ^^^: ExponentialPrecedence
 
func ^^^ (base: Int, power: Int) -> Double
{
    return pow(Double(base), Double(power))
}

private var isAddedOpenBracket = false
private var isAddedCloseBracket = false
private var userIsInTheMiddleOfTypingANumber = false

class CalculatorOperation {
    
    enum Operation {
        case Constant(Double)
        case Variable(() -> Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case Undo
        case Clear
    }
    
    var operations: Dictionary<String, Operation> = [
        "√": Operation.UnaryOperation(sqrt),
        "%": Operation.UnaryOperation({ $0 / 100 }),
        "±": Operation.UnaryOperation({ -$0 }),
        "×": Operation.BinaryOperation(*),
        "÷": Operation.BinaryOperation(/),
        "+": Operation.BinaryOperation(+),
        "−": Operation.BinaryOperation(-),
        "=": Operation.Equals,
        "←": Operation.Undo,
        "AC": Operation.Clear
    ]
    
    //MARK: - Properties
    var stringNumbers: [String] = [String()]
    var strExpress : String = ""
    var operators: [String] = [""]
    var index = 0
    weak var countOnMeDelegate: CountOnMeDelegate?
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {

                } else {

                }
                return false
            }
        }
        return true
    }
    
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        return true
    }
    
    //MARK: - Methods
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        strExpress.append("\(newNumber)")
        updateDisplay()
    }
    
    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }
        countOnMeDelegate?.updateOutput(strOutput: "\(strExpress.calculate() ?? 0.0)")
        clear()
    }
    
    func clear() {
        stringNumbers = [String()]
        operators = [""]
        index = 0
        strExpress = ""
    }
    
    func divide() {
        if canAddOperator {
            operators.append("÷")
            strExpress.append("/")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    
    func multiply() {
        if canAddOperator {
            operators.append("x")
            strExpress.append("*")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    
    func minus() {
        if canAddOperator {
            operators.append("-")
            strExpress.append("-")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    
    func plus() {
        if canAddOperator {
            operators.append("+")
            strExpress.append("+")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    
    func updateDisplay() {
        var text = ""
        for (index, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if index > 0 {
                text += operators[index]
            }
            // Add number
            text += stringNumber
        }
        countOnMeDelegate?.updateCal(strCalulation: "\(text)")
    }
}

//
//  ExtensionClass.swift
//  flytbaseDemo
//
//  Created by vaibhav bhosale on 20/08/20.
//  Copyright © 2020 VB. All rights reserved.
//

import UIKit

@IBDesignable public class RoundedButton: UIButton {
    override public func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }
}

extension UIButton {
    func setCircule() {
        self.layer.cornerRadius = self.frame.height / 2;
        self.layer.masksToBounds = true
    }
}

extension String {
    private func allNumsToDouble() -> String {
        let symbolsCharSet = ".,"
        let fullCharSet = "0123456789" + symbolsCharSet
        var i = 0
        var result = ""
        let chars = Array(self)
        while i < chars.count {
            if fullCharSet.contains(chars[i]) {
                var numString = String(chars[i])
                i += 1
                loop: while i < chars.count {
                    if fullCharSet.contains(chars[i]) {
                        numString += String(chars[i])
                        i += 1
                    } else {
                        break loop
                    }
                }
                if let num = Double(numString) {
                    result += "\(num)"
                } else {
                    result += numString
                }
            } else {
                result += String(chars[i])
                i += 1
            }
        }
        return result
    }

    func calculate() -> Double? {
        let transformedString = allNumsToDouble()
        let expr = NSExpression(format: transformedString)
        return expr.expressionValue(with: nil, context: nil) as? Double
    }
    
    func matches(for regex: String) -> [String] {
        do {
            let pattern = regex
            let regex = try NSRegularExpression(pattern: pattern)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            return results.map
                {
                    String(self[Range($0.range, in: self)!])
            }
        }
        catch {
            return []
        }
    }
    
    func match()-> String {
        var strCal = self
        strCal = strCal.replacingOccurrences(of: "x", with: "*")
        strCal = strCal.replacingOccurrences(of: "÷", with: "/")
        let expn = NSExpression(format:strCal)
        
        if let result:Any = (expn.expressionValue(with: nil, context: nil)) {
            return (result as AnyObject).stringValue
        }
        else {
            return ""
        }
    }
}

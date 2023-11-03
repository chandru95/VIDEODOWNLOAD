//
//  Extensions.swift
//  VideoDownloadTask
//
//  Created by Alen c james on 22/09/23.
//

import Foundation
import UIKit
extension Dictionary where Key == String {
    
    func getBoolFromDict(key:String)->Bool {
        if let objectValue = self[key] as? Bool  {
            return objectValue
        }else if let objectValue = self[key] as? Int  {
            return (objectValue == 1) ? true : false
        }else if let objectValue = self[key] as? String  {
            return (objectValue == "1") ? true : false
        }
        return false
    }
    
    func getIntAsStringFromDict(key:String)->String {
        if let objectValue = self[key] as? Int  {
            return "\(objectValue)"
        }else if let objectValue = self[key] as? String  {
            return objectValue
        }
        return ""
    }
    
    func getNumberAsString(key:String)->String {
        if let objectValue = self[key] as? Int  {
            return "\(objectValue)"
        }else if let objectValue = self[key] as? Double  {
            return "\(objectValue)"
        }else if let objectValue = self[key] as? Float  {
            return "\(objectValue)"
        }else if let objectValue = self[key] as? String  {
            return objectValue
        }
        return ""
    }
    
    func getString(key:String)->String {
        return self[key] as? String ?? ""
    }
    
    func getDict(key:String)->[String:Any] {
        return self[key] as? [String:Any] ?? [:]
    }
    
    func getInt(key:String)->Int {
        if let objectValue = self[key] as? Int  {
            return objectValue
        }else if let objectValue = self[key] as? String  {
            return Int(objectValue) ?? 0
        }else if let objectValue = self[key] as? Double  {
            return Int(objectValue)
        }
        return 0
    }
    
    func getFloat(key:String) ->Float {
        if let objectValue = self[key] as? Int  {
            return Float(objectValue)
        }else if let objectValue = self[key] as? Double  {
            return Float(objectValue)
        }else if let objectValue = self[key] as? Float  {
            return objectValue
        }else if let objectValue = self[key] as? String  {
            return Float(objectValue) ?? 0
        }
        return 0
    }
    
    func toJSON() -> String {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: []) {
            if let theJSONText = String(data: theJSONData, encoding: .ascii) {
                return theJSONText
            }
        }
        return ConstantString.k_EMPTY
    }
    
    func toJSONutf8() -> String {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: []) {
            if let theJSONText = String(data: theJSONData, encoding: .utf8) {
                return theJSONText
            }
        }
        return ConstantString.k_EMPTY
    }
    
}

extension Array {
    func toJSON() -> String {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: []) {
            if let theJSONText = String(data: theJSONData, encoding: .ascii) {
                return theJSONText
            }
        }
        return ConstantString.k_EMPTY
    }
}

extension String {
    func spaceRemoved() ->String {
            return self.replacingOccurrences(of: " ", with: "%20")
        }
    
    func attributedText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: self)
        if let asteriskRange = self.range(of: "*") {
            let nsRange = NSRange(asteriskRange, in: self)
            let textColor = UIColor(red: 158/255, green: 40/255, blue: 70/255, alpha: 1).cgColor
            attributedText.addAttribute(.foregroundColor, value: textColor, range: nsRange)
        }
        return attributedText
    }
}
extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}
extension Float {
    func roundedToIntString() -> String {
        let roundedValue = Int(self.rounded())
        //return "\(roundedValue)°C"
        return String(roundedValue)
    }
}

extension Int {
    func daySuffix() -> String {
        if self >= 11 && self <= 13 {
            return "th"
        }
        switch self % 10 {
        case 1:
            return "st"
        case 2:
            return "nd"
        case 3:
            return "rd"
        default:
            return "th"
        }
    }
}






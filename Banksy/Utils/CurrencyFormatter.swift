//
//  CurrencyFormatter.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 28/05/2022.
//

import Foundation
import UIKit

public class CurrencyFormatter{
    
    init(){}
    
    static var shared:CurrencyFormatter = .init()
    
    func fancyAttributedString(_ value:Float) -> NSMutableAttributedString?{
        guard let (dollar,cents) = formattedString(value) else {
            print("(DEBUG) The Whole Figure (Dollars) or Decimal Fiigures (Cents) are missing")
            return nil
        }
        
        return self.makeFancyAttributedText(dollars: dollar, cents:cents)
    }
    
    func formattedString(_ value:Float) -> (String,String)?{
        let elements = self.split(floatValue: value)
        
        guard let dollar = elements.first,let cents = elements.last else {
            print("(DEBUG) The Whole Figure (Dollars) or Decimal Fiigures (Cents) are missing")
            return nil
        }
        
        return (self.convertFloatIntoFancyString(dollar), cents.count > 2 ? String(cents.dropLast(cents.count - 2)) : cents)
    }

    
    func convertFloatIntoFancyString(_ value:String? = nil, float_value:Float? = nil) -> String{
        var floatString = value ?? "\(float_value ?? 0)"
        var splitNumbers:[String] = []
        var count:Int = 0
        
        while !floatString.isEmpty{
            if count != 3{
                count+=1
            }else{
                var subStr = ""
                while count != 0 && !floatString.isEmpty{
                    if let last = floatString.last{
                        subStr += String(last)
                        floatString = String(floatString.dropLast())
                        count -= 1
                    }
                }
                
                if !subStr.isEmpty{
                    splitNumbers.append(subStr)
                }
            }
        }
        
        let result = !splitNumbers.isEmpty ? splitNumbers.reversed().map({String($0.reversed())}).reduce("", {$0.isEmpty ? $1 : $0+","+$1}) : ""
        
        return result
        
    }
    
    func split(floatValue:Float) -> [String]{
        return ("\(floatValue)".split(separator: ".")).compactMap({String($0)})
    }
    
    
    private func makeFancyAttributedText(dollars:String,cents:String) -> NSMutableAttributedString{
        
        let dollarSignAttribute:[NSAttributedString.Key:Any] = [.font:UIFont.preferredFont(forTextStyle: .callout),.baselineOffset:8]
        let dollarAttribute:[NSAttributedString.Key:Any] = [.font:UIFont.preferredFont(forTextStyle: .title1)]
        let centAttribute:[NSMutableAttributedString.Key:Any] = [.font:UIFont.preferredFont(forTextStyle: .footnote),.baselineOffset:8]
        
        let rootText:NSMutableAttributedString = .init(string: "$", attributes: dollarSignAttribute)
        rootText.append(.init(string: dollars, attributes: dollarAttribute))
        rootText.append(.init(string: cents, attributes: centAttribute))
        
        return rootText
    }
    
}

//
//  StringExtension.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 28/05/2022.
//

import Foundation

extension String{
    
    public static func convertFloatIntoFancyString(_ value:String? = nil, float_value:Float? = nil) -> String{
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
    
}

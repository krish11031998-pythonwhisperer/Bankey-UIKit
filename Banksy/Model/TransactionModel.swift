//
//  TransactionModel.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 27/05/2022.
//

import Foundation

enum TransactionType:String,Codable{
    case creditCard = "Credit Card"
    case banking = "Banking"
    case investment = "Investment"
}

struct TransactionModel:Codable{
    var type:TransactionType
    var description:String
    var value:Float
}

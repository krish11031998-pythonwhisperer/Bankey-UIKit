//
//  CurrencyFormatterTests.swift
//  BanksyUnitTests
//
//  Created by Krishna Venkatramani on 28/05/2022.
//

import Foundation
import XCTest

@testable import Banksy

class CurrencyFormatterTest:XCTest{
    var formatter:CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        self.formatter = CurrencyFormatter()
    }
    
    func testFormattedString() throws{
        let floatValue:Float = 5001.980
        guard let (dollar,cents) = self.formatter.formattedString(floatValue) else {
            XCTAssertThrowsError("(Error) dollar and cents are nil, should NOT be nil!")
            return
        }
        
        XCTAssertEqual(dollar, "5,001")
        XCTAssertEqual(cents, "980")
    }
    
    func testDollarFormatter() throws{
        let floatValue:Float = 500234
        let formattedString = String.convertFloatIntoFancyString(float_value: floatValue)
        print("(DEBUG) formattedString : ",formattedString)
        XCTAssertEqual(formattedString, "500,235")
    }
}

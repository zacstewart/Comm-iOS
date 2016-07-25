//
//  AddressTest.swift
//  Comm
//
//  Created by Zac Stewart on 7/24/16.
//  Copyright © 2016 Zac Stewart. All rights reserved.
//

import XCTest
@testable import Comm

class AddressTests: XCTestCase {
    func testForContent() {
        let address = Address.forContent("alpha")
        XCTAssertEqual(address.toString()!, "be76331b95dfc399cd776d2fc68021e0db03cc4f")
    }

    func testFromString() {
        let address = Address.fromString("be76331b95dfc399cd776d2fc68021e0db03cc4f")
        XCTAssertEqual(address.toString()!, "be76331b95dfc399cd776d2fc68021e0db03cc4f")
    }

    func testNull() {
        let address = Address.null()
        XCTAssertEqual(address.toString()!, "0000000000000000000000000000000000000000")
    }

    func testCopy() {
        var address: Address? = Address.fromString("0000000000000000000000000000000000000001")
        let copy = address!.copy() as! Address
        XCTAssertEqual(address!.toString()!, copy.toString()!)
        address = nil // deinit the original
        XCTAssertEqual(copy.toString()!, "0000000000000000000000000000000000000001")
    }
}

//
//  MaChTests.swift
//  MaChTests
//
//  Created by Grzegorz Moscichowski on 20/08/2019.
//  Copyright © 2019 Grzegorz Moscichowski. All rights reserved.
//

import XCTest
import Alamofire
import SwiftyJSON

@testable import MaCh

class MaChTests: XCTestCase {
    
    func testReadFromPLC() {
        let exp = XCTestExpectation()
        WagoMemoryNetworkAPI.shared.getData(atRange: .everything) { (result, error) in
            XCTAssert(result?.first != nil)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }
    
    func testSaveFromPLC() {
        let exp = XCTestExpectation()
        let commands = MockWriteCommands.setFirst4(withValue: 7)
        WagoMemoryNetworkAPI.shared.writeCommands(commands,
                                                  readRange: .everything) { (result, error) in
                                                    XCTAssert(result?.first != nil)
                                                    print(result ?? "")
                                                    exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }
    
}

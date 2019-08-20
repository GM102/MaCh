//
//  MaChTests.swift
//  MaChTests
//
//  Created by Grzegorz Moscichowski on 20/08/2019.
//  Copyright © 2019 Grzegorz Moscichowski. All rights reserved.
//

import XCTest
import Alamofire
@testable import MaCh

class MaChTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testReadFromPLC() {
        let exp = XCTestExpectation()
        Alamofire.request("http://192.168.1.201/webserv/samples/all_hex.ssi", method: .get, parameters: nil).validate().responseString { (response) in
            print(response)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }
    
    func testSaveFromPLC() {
        let exp = XCTestExpectation()
        let params = ["ADR1":"MB0",
                      "VALUE1":"03",
                      "FORMAT1":"%d"]
        let headers = ["Referer:": "http://192.168.1.201/webserv/samples/all_hex.ssi"]
        Alamofire.request("http://192.168.1.201/WRITEPI", method: .post, parameters: params, encoding:URLEncoding.httpBody, headers:headers).validate().responseJSON { (response) in
            print(response)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//
//  PlistFileTests.swift
//  StudyGuideTests
//
//  Created by Alberto Dominguez on 11/14/21.
//

import XCTest
@testable import Study_Guide


class PlistFileTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: Save Tests
    
    // test saving data
    func testAddValuesToPlistFile() {
        
        let person = PlistFile(filename: "Person")
        
    }
}

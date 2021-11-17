//
//  FileManagerFileTests.swift
//  StudyGuideTests
//
//  Created by Alberto Dominguez on 11/14/21.
//

import XCTest
@testable import Study_Guide

class FileManagerFileTests: XCTestCase {

    
    // MARK: SAVE methods
    
    // Test if you can save to File Manager
    func testCanSave() {
        let file = FileManagerFile(location: .documents, filename: "foobar.txt")
        
        file.save(string: "Hello world!")
        
        var fileExists: Bool = false
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        
        if let pathComponent = url.appendingPathComponent("foobar.txt") {
            let filePath = pathComponent.path
            
            fileExists = FileManager.default.fileExists(atPath: filePath)
        }
        
        XCTAssertTrue(fileExists)
    }
    
    
    
    // MARK: READ methods
    
    // Test if you can read WITHOUT saving first
    func testReadWithoutSavingTheFile() {
        let file = FileManagerFile(location: .documents, filename: "testReadWithoutSavingTheFile.txt")
        let content: String? = file.contents()
        
        /// check if content is nil
        XCTAssertNil(content)
    }
    
    // Test contents<T: Decodable>() -> T? with saving first
    func testReadTypePerson() {
        let file = FileManagerFile(location: .documents, filename: "foobar.json")
        
        let john = PersonInfo(name: "John", age: 22, height: 6)
        
        file.save(encodable: john)
        
        let content: PersonInfo? = file.contents()
        
        /// check if content is nil
        XCTAssertEqual(john, content)
    }
    
    // Test contents() -> String? with saving first
    func testReadTypeString() {
        let file = FileManagerFile(location: .documents, filename: "foobar.txt")
        
        let john = "John"
        
        file.save(string: john)
        
        let content: String? = file.contents()
        
        /// check if content is nil
        XCTAssertEqual(john, content)
    }
    
    // Test contents() -> Data? with saving first
    func testReadTypeData() {
        let file = FileManagerFile(location: .documents, filename: "foobar.txt")
        
        let stringAsData: Data? = "unitTest".data(using: .utf8)
        
        file.save(data: stringAsData!)
        
        let content: Data? = file.contents()
        
        /// check if content is nil
        XCTAssertEqual(stringAsData, content)
    }
}

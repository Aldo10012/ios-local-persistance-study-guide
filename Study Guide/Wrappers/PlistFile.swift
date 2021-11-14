//
//  Plist.swift
//  Study Guide
//
//  Created by Erick Sanchez on 11/1/21.
//
//  code inspired by this StackOverFlow:
//  https://stackoverflow.com/questions/25100262/save-data-to-plist-file-in-swift
//

import Foundation

class PlistFile {
    
    // MARK: Properties
    enum PlistError: Error {
        case FileNotWritten
        case FileDoesNotExist
    }

    var fileName: String?
    
    var sourcePath:String? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist") else { return nil }
        return path
    }
    
    var destPath:String? {
        guard sourcePath != nil else { return nil }
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return (dir as NSString).appendingPathComponent("\(fileName).plist")
    }
    
    // MARK: Init
    /// Load a plist file from the Bundle.main
    init?(filename: String) {
        self.fileName = filename
                
        let fileManager = FileManager.default
        
        guard let source = sourcePath else { return nil }
        guard let destination = destPath else { return nil }
        guard fileManager.fileExists(atPath: source) else { return nil }
        
        if !fileManager.fileExists(atPath: destination) {
            
            do {
                try fileManager.copyItem(atPath: source, toPath: destination)
            } catch let error as NSError {
                print("Unable to copy file. ERROR: \(error.localizedDescription)")
                return nil
            }
        }
    }

    /// Load a plist file from the given url (e.g. stored in the app's Sandbox in the Documents/ folder)
    init?(fileURL: URL) {
        self.fileName = fileURL.absoluteString
                
        let fileManager = FileManager.default
        
        guard let source = sourcePath else { return nil }
        guard let destination = destPath else { return nil }
        guard fileManager.fileExists(atPath: source) else { return nil }
        
        if !fileManager.fileExists(atPath: destination) {
            
            do {
                try fileManager.copyItem(atPath: source, toPath: destination)
            } catch let error as NSError {
                print("Unable to copy file. ERROR: \(error.localizedDescription)")
                return nil
            }
        }
    }
    
    
    // MARK: Create / Update
    /// Store the given contents at the given url
//    static func store(contents: [String: Any], at url: URL) {
//        fatalError("not implemented, yet")
//    }
//
//
//    /// Store the given contents in the plist
//    func store(contents: [String: Any]) {
//        fatalError("not implemented, yet")
//    }
    
    
    
    func getMutablePlistFile() -> NSDictionary?{
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: destPath!) {
            guard let dict = NSDictionary(contentsOfFile: destPath!) else { return nil }
            return dict
        } else {
            return nil
        }
    }
    
    func addValuesToPlistFile(dictionary: NSDictionary) throws {
        let fileManager = FileManager.default
        let dictionary = dictionary
        let dict = getMutablePlistFile()!
        
//        let comibeDict = dictionary + dict
        
        for (key, value) in dictionary where key is String {
            dict.setValue(value, forKey: key as! String)
        }
        
        if fileManager.fileExists(atPath: destPath!) {
            if !dict.write(toFile: destPath!, atomically: false) {
                print("File not written successfully")
                throw PlistError.FileNotWritten
            }
        } else {
            throw PlistError.FileDoesNotExist
        }
    }

    
    
    
    // MARK: Read
    /// Read all contents from the plist     -     This ONLY works if the root is a dictionary. If it's an array, it needs to return NSArray
    func read() -> NSDictionary? {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: destPath!) {
            guard let dict = NSDictionary(contentsOfFile: destPath!) else { return nil }
            return dict
        } else {
            return nil
        }
    }
    

    // MARK: Delete
    /// Delete the plist file
    func delete() {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: destPath!) {
            do { try fileManager.removeItem(atPath: destPath!) }
            catch { print(PlistError.FileDoesNotExist) }
        }
    }
}







// helper extensions
// https://gist.github.com/codelynx/7a59fc1f5cbc14a73036431960e5291b
extension NSDictionary {

    public static func + (lhs: NSDictionary, rhs: NSDictionary) -> NSDictionary {
        let dictionary = NSMutableDictionary()
        for (key, value) in lhs {
            if let key = key as? NSCopying {
                dictionary[key] = value
            }
        }
        for (key, valueR) in rhs {
            if let key = key as? NSCopying {
                if let valueL = lhs[key] {
                    switch (valueL, valueR) {
                    case (let dictionaryL as NSDictionary, let dictionaryR as NSDictionary):
                        dictionary[key] = dictionaryL + dictionaryR
                        break
                    case (let arrayL as NSArray, let arrayR as NSArray):
                        dictionary[key] = arrayL + arrayR
                    default:
                        dictionary[key] = valueR
                    }
                }
                else {
                    dictionary[key] = valueR
                }
            }
        }
        return dictionary
    }

}

extension NSMutableDictionary {

    public static func += (lhs: inout NSMutableDictionary, rhs: NSDictionary) {
        for (key, valueR) in rhs {
            if let valueL = lhs[key] {
                switch (valueL, valueR) {
                case (let dictionaryL as NSDictionary, let dictionaryR as NSDictionary):
                    lhs[key] = dictionaryL + dictionaryR
                case (let arrayL as NSArray, let arrayR as NSArray):
                    lhs[key] = arrayL + arrayR
                default:
                    lhs[key] = valueR
                }
            }
            else {
                lhs[key] = valueR
            }
        }
    }

}

extension NSArray {

    public static func + (lhs: NSArray, rhs: NSArray) -> NSArray {
        let array = NSMutableArray()
        lhs.forEach { array.add($0) }
        rhs.forEach { array.add($0) }
        return array
    }

}

extension NSMutableArray {

    public static func += (lhs: inout NSMutableArray, rhs: NSArray) {
        for value in rhs {
            lhs.add(value)
        }
    }

}

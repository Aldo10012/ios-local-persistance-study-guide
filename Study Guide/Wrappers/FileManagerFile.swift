//
//  File.swift
//  Study Guide
//
//  Created by Erick Sanchez on 11/1/21.
//

import Foundation

/// File store that represents one file in the app's Sandbox
///
/// Here's an exmaple storing an image in the library cache:
/// ```
/// func cacheUserProfileImage(_ image: UIImage) {
///     let userProfileImageFile = FileManagerFile(location: .libraryCache, filename: "UserProfile.png")
///     guard let userProfileImageData = image.pngData() else {
///         return print("Failed to create image data from image")
///     }
///
///     userProfileImageFile.save(contents: userProfileImageData)
/// }
/// ```
class FileManagerFile {
    enum Location {
        case documents
        case library
        case libraryCache
        case temp
    }
    var filename: String
    
    init(location: Location, filename: String) {
        self.filename = filename
    }
    
    init(location: Location, subdirectory: String, filename: String) {
        // TODO: Stretch Challenge: create folders if they do not exists in the save methods of this class
        self.filename = filename
    }
    
    
    
    // MARK: Create / Update
    /// Store the given string in the file
    ///
    /// - Note: if the file does not exist, this method will create it. Otherwise, this
    /// method will override the file's contents
    func save(contents: String) {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)

        if let documentDirectory: URL = urls.first {
            let documentURL = documentDirectory.appendingPathComponent(filename)
            // data you want to write to file
            let data: Data? = contents.data(using: .utf8)
            do{
              try data!.write(to: documentURL, options: .atomic)
            }catch{
                // some error
            }
        }
    }
    
    /// Store the given encodable contents in the file
    ///
    /// - Note: if the file does not exist, this method will create it. Otherwise, this
    /// method will override the file's contents
    func save<T: Encodable>(contents: T) {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)

        if let documentDirectory: URL = urls.first {
            print(documentDirectory) /// print file path
            let documentURL = documentDirectory.appendingPathComponent(filename)
            
            // data you want to write to file
            let personInfo = contents
            let data = try! JSONEncoder().encode(personInfo)
            
            do{
              try data.write(to: documentURL, options: .atomic)
            }catch{
                print("ERROR failed to write data to file")
            }
        }
    }
    
    /// Store the given data in the file
    ///
    /// - Note: if the file does not exist, this method will create it. Otherwise, this
    /// method will override the file's contents
    func save(contents: Data) {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)

        if let documentDirectory: URL = urls.first {
            print(documentDirectory) /// print file path
            let documentURL = documentDirectory.appendingPathComponent(filename)
            
            // data you want to write to file
            let data = contents
            
            do{
              try data.write(to: documentURL, options: .atomic)
            }catch{
                print("ERROR failed to write data to file")
            }
        }
    }
    
    
    // MARK: Read
    /// Read the contents of the file as `String`
    ///
    /// - Note: if the file does not exist, this method will return nil
    func contents() -> String? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        var result: String?

        if let documentDirectory: URL = urls.first {
            let documentURL = documentDirectory.appendingPathComponent(filename)
            
            guard let data = try? Data(contentsOf: documentURL) else {return nil}
            do {
                result = String(decoding: data, as: UTF8.self)
            }
            catch {
                print("ERROR converting JOSN into String")
            }
        }
        return result
    }
    
    /// Read the contents of the file as the given decodable type
    ///
    /// - Note: if the file does not exist, this method will return nil. Or, if the stored contents
    /// is not the same as the decodable type, this method will return nil
    func contents<T: Decodable>() -> T? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        var result: T?

        if let documentDirectory: URL = urls.first {
            let documentURL = documentDirectory.appendingPathComponent(filename)
            
            guard let data = try? Data(contentsOf: documentURL) else {return nil}
            do {
                result = try JSONDecoder().decode(T.self, from: data)
            }
            catch {
                print("ERROR converting JOSN into String")
            }
        }
        return result
    }
    
    /// Read the contents of the file as `Data`
    ///
    /// - Note: if the file does not exist, this method will return nil
    func contents() -> Data? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        var result: Data?
        
        if let documentDirectory: URL = urls.first {
            let documentURL = documentDirectory.appendingPathComponent(filename)
            
            guard let data = try? Data(contentsOf: documentURL) else {return nil}
            result = data
        }
        
        return result
    }
    
    
    // MARK: Delete
    /// Delete the file
    ///
    /// - Note: if the file does not exist, this method does nothing
    func delete() {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        if let documentDirectory: URL = urls.first {
            let documentURL = documentDirectory.appendingPathComponent(filename)
            
            // Check if file exists
            if fileManager.fileExists(atPath: filename) {
                // Delete file
                do {
                    try fileManager.removeItem(atPath: filename)
                } catch {
                    print("error")
                }
            } else {
                print("File does not exist")
            }
        }
        
    }
}

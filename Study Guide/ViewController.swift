//
//  ViewController.swift
//  Study Guide
//
//  Created by Erick Sanchez on 11/1/21.
//

import UIKit

struct PersonInfo: Codable, Equatable {
    let name: String
    let age: Int
    let height: CGFloat // inches
}

let userPassword = "This!sNOTaGoodpassword"

let imageProfile = UIImage(named: "box")!

let preferences: [String: Any] = [
    "FIRST_TIME_LAUNCH": false,
    "COLORS": [
        [
            "first": "blue",
            "second": "green",
        ],
        [
            "first": "orange",
            "second": "yellow",
        ],
        [
            "first": "green",
            "second": "yellow",
        ],
    ]
]

let randomData = "SJI$#J*(GJDS*(G S)(FSDJ)(FJ DSF()@! HFDS".data(using: .utf8)!

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // TODO: test each wrapper with the data at the top of this Swift file
        
        // MARK: Testing User Defaults
        print(testingUserDefualts)
        let ud = UserDefaultsStore<[String:Any]>()
        ud.storeValue(key: "data", value: preferences)
        print(ud.read(fromKey: "data"))
        ud.delete(key: "data")
        
        
        print(testingPList)
        // MARK: Testing PList wrapper
        let plist = PlistFile(filename: "Person")!
        print(plist.read())
        
        // adding to plist
        var dict = plist.getMutablePlistFile()!
        dict = ["race": "Mixed"] as! NSDictionary
        do {
            try plist.addValuesToPlistFile(dictionary: dict)
        } catch {
            print(error)
        }
        
        print(plist.read())
        
        
        print(testingFileManager)
        let fManager = FileManagerFile(location: .documents, filename: "data.json")
        let person = PersonInfo(name: "Bob", age: 22, height: 6.0)
        fManager.save(encodable: person)
        let contents: PersonInfo? = fManager.contents() 
        print(contents)

    }
    


}

let testingUserDefualts =
"""
***************************
*  TESTING USER DEFAULTS  *
***************************\n
"""

let testingPList =
"""
\n***************************
*     TESTING PLISTS      *
***************************\n
"""

let testingFileManager =
"""
\n***************************
*      File Manager       *
***************************\n
"""

//
//  User.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 17/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation
import os.log

class User: NSObject, NSCoding {
    
    //MARK: Properties
    
    var firstname: String?
    var lastname: String?
    var imageUrl: NSURL?
    
    //MARK: Archiving Paths

    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Users")
    
    //MARK: Types
    
    struct PropertyKey {
        static let firstname = "Cfirstname"
        static let lastname = "Clastname"
        static let imageurl = "Cimageurl"
    }
    
    //MARK: Initialization

    init(first: String, last: String, url: NSURL) {
        self.firstname = first
        self.lastname = last
        self.imageUrl = url
    }
    
    //MARK: NSCoding

    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstname, forKey: PropertyKey.firstname)
        aCoder.encode(lastname, forKey: PropertyKey.lastname)
        aCoder.encode(imageUrl?.path, forKey: PropertyKey.imageurl)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let firstname = aDecoder.decodeObject(forKey: PropertyKey.firstname) as? String else {
            os_log("Unable to decode the name.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let lastname = aDecoder.decodeObject(forKey: PropertyKey.lastname) as? String else {
            os_log("Unable to decode the lastname.", log: OSLog.default, type: .debug)
            return nil
        }
        let imageurl = aDecoder.decodeObject(forKey: PropertyKey.imageurl) as? String
        var url = NSURL(fileURLWithPath: "")
        if (imageurl != nil)
        {
            url = NSURL(fileURLWithPath: imageurl!)
        }
        self.init(first: firstname, last: lastname, url: url)
    }
}

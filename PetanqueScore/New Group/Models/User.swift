//
//  User.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 17/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    var firstname: String?
    
    var lastname: String?
    
    var imageUrl: NSURL?
    
    init(first: String, last: String, url: NSURL?) {
        self.firstname = first
        self.lastname = last
        self.imageUrl = url
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("users")
    
    struct PropertyKey {
        static let firstname = "Cfirstname"
        static let lastname = "Clastname"
        static let imageurl = "Cimageurl"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.firstname, forKey: PropertyKey.firstname)
        aCoder.encode(self.lastname, forKey: PropertyKey.lastname)
        aCoder.encode(self.imageUrl?.path, forKey: PropertyKey.imageurl)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let firstname = aDecoder.decodeObject(forKey: PropertyKey.firstname) as? String
        let lastname = aDecoder.decodeObject(forKey: PropertyKey.lastname) as? String
        let imageurl = aDecoder.decodeObject(forKey: PropertyKey.imageurl) as? String
        let url = NSURL(fileURLWithPath: imageurl!)
        self.init(first: firstname!, last: lastname!, url: url)
    }
    
}

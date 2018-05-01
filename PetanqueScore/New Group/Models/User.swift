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
    var nbrVictoire: Int?
    var bouleDesc: String?
    var totalGames: Int?
    
    //MARK: Archiving Paths

    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Users")
    
    //MARK: Types
    
    struct PropertyKey {
        static let firstname = "Cfirstname"
        static let lastname = "Clastname"
        static let imageurl = "Cimageurl"
        static let nbrVictoire = "CnbrVictoire"
        static let bouleDesc = "CbouleDesc"
        static let totalGames = "CtotalGames"
    }
    
    //MARK: Initialization

    init(first: String, last: String, url: NSURL, nbrVictoire: Int = 0, bouleDesc: String = "", totalGames: Int = 0) {
        self.firstname = first
        self.lastname = last
        self.imageUrl = url
        self.bouleDesc = bouleDesc
        self.nbrVictoire = nbrVictoire
        self.totalGames = totalGames
    }
    
    //MARK: NSCoding

    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstname, forKey: PropertyKey.firstname)
        aCoder.encode(lastname, forKey: PropertyKey.lastname)
        aCoder.encode(imageUrl?.path, forKey: PropertyKey.imageurl)
        aCoder.encode(bouleDesc, forKey: PropertyKey.bouleDesc)
        aCoder.encode(nbrVictoire, forKey: PropertyKey.nbrVictoire)
        aCoder.encode(totalGames, forKey: PropertyKey.totalGames)
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
        let bouleDesc = aDecoder.decodeObject(forKey: PropertyKey.bouleDesc) as? String ?? ""
        let nbrVict = aDecoder.decodeObject(forKey: PropertyKey.nbrVictoire) as? Int ?? 0
        let totalGames = aDecoder.decodeObject(forKey: PropertyKey.totalGames) as? Int ?? 0
        self.init(first: firstname, last: lastname, url: url, nbrVictoire: nbrVict, bouleDesc: bouleDesc, totalGames: totalGames)
    }
}

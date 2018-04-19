//
//  Game.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 19/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

import Foundation
import os.log

class Game: NSObject {
    
    //MARK: Properties
    
    var equipe1: [User]
    var equipe2: [User]
    var victNumber: Int
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Games")
    
    //MARK: Types
    
    struct PropertyKey {
        static let equipe1 = "Cequipe1"
        static let equipe2 = "Cequipe2"
        static let victNumber = "CvictNumber"
    }
    
    //MARK: Initialization
    
    init(equipe1: [User], equipe2: [User], victNumber: Int)
    {
        self.equipe1 = equipe1
        self.equipe2 = equipe2
        self.victNumber = victNumber
    }
    
    //MARK: NSCoding
    /*
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
    }*/
}

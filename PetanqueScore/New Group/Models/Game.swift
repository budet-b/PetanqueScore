//
//  Game.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 19/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

class Game: NSObject, NSCoding {
    
    //MARK: Properties
    
    var equipe1: [User]
    var equipe2: [User]
    var victNumber: Int
    var equipe1Name: String
    var equipe2Name: String
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Games")
    
    //MARK: Types
    
    struct PropertyKey {
        static let equipe1 = "Cequipe1"
        static let equipe2 = "Cequipe2"
        static let victNumber = "CvictNumber"
        static let equipe1Name = "Cequipe1Name"
        static let equipe2Name = "Cequipe2Name"
    }
    
    //MARK: Initialization
    
    init(equipe1: [User], equipe2: [User], victNumber: Int, equipe1Name: String, equipe2Name: String)
    {
        self.equipe1 = equipe1
        self.equipe2 = equipe2
        self.victNumber = victNumber
        self.equipe1Name = equipe1Name
        self.equipe2Name = equipe2Name
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(equipe1, forKey: PropertyKey.equipe1)
        aCoder.encode(equipe2, forKey: PropertyKey.equipe2)
        aCoder.encode(victNumber, forKey: PropertyKey.victNumber)
        aCoder.encode(equipe1Name, forKey: PropertyKey.equipe1Name)
        aCoder.encode(equipe2Name, forKey: PropertyKey.equipe2Name)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let equipe1 = aDecoder.decodeObject(forKey: PropertyKey.equipe1) as? [User] else {
            return nil
        }
        guard let equipe2 = aDecoder.decodeObject(forKey: PropertyKey.equipe2) as? [User] else {
            return nil
        }
        guard let victNumber = aDecoder.decodeObject(forKey: PropertyKey.victNumber) as? Int else {
            return nil
        }
        guard let equipe1Name = aDecoder.decodeObject(forKey: PropertyKey.equipe1Name) as? String else {
            return nil
        }
        guard let equipe2Name = aDecoder.decodeObject(forKey: PropertyKey.equipe2Name) as? String else {
            return nil
        }
        self.init(equipe1: equipe1, equipe2: equipe2, victNumber: victNumber, equipe1Name: equipe1Name, equipe2Name: equipe2Name)
    }
}

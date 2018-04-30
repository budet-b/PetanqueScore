//
//  Game.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 19/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation
import MapKit

class Game: NSObject, NSCoding {
    
    //MARK: Properties
    
    var equipe1: [User]?
    var equipe2: [User]?
    var victNumber: Int?
    var equipe1Name: String?
    var equipe2Name: String?
    var equipe1Score: Int?
    var equipe2Score: Int?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var location: CLLocationCoordinate2D?
    
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
        static let equipe1Score = "Cequipe1Score"
        static let equipe2Score = "Cequipe2Score"
        static let longitude = "Clongitude"
        static let latitude = "Clatitude"
    }
    
    //MARK: Initialization
    
    init(equipe1: [User], equipe2: [User], victNumber: Int, equipe1Name: String, equipe2Name: String, equipe1Score: Int, equipe2Score: Int, longitude: CLLocationDegrees?, latitude: CLLocationDegrees?)
    {
        self.equipe1 = equipe1
        self.equipe2 = equipe2
        self.victNumber = victNumber
        self.equipe1Name = equipe1Name
        self.equipe2Name = equipe2Name
        self.equipe1Score = equipe1Score
        self.equipe2Score = equipe2Score
        self.longitude = longitude
        self.latitude = latitude
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(equipe1, forKey: PropertyKey.equipe1)
        aCoder.encode(equipe2, forKey: PropertyKey.equipe2)
        aCoder.encode(victNumber, forKey: PropertyKey.victNumber)
        aCoder.encode(equipe1Name, forKey: PropertyKey.equipe1Name)
        aCoder.encode(equipe2Name, forKey: PropertyKey.equipe2Name)
        aCoder.encode(equipe1Score, forKey: PropertyKey.equipe1Score)
        aCoder.encode(equipe2Score, forKey: PropertyKey.equipe2Score)
        aCoder.encode(longitude, forKey: PropertyKey.longitude)
        aCoder.encode(latitude, forKey: PropertyKey.latitude)
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
        guard let equipe1Score = aDecoder.decodeObject(forKey: PropertyKey.equipe1Score) as? Int else {
            return nil
        }
        guard let equipe2Score = aDecoder.decodeObject(forKey: PropertyKey.equipe2Score) as? Int else {
            return nil
        }
        let longitude = aDecoder.decodeObject(forKey: PropertyKey.longitude) as? CLLocationDegrees
        
        let latitude = aDecoder.decodeObject(forKey: PropertyKey.latitude) as? CLLocationDegrees
        
        self.init(equipe1: equipe1, equipe2: equipe2, victNumber: victNumber, equipe1Name: equipe1Name, equipe2Name: equipe2Name, equipe1Score: equipe1Score, equipe2Score: equipe2Score, longitude: longitude, latitude: latitude)
    }
}

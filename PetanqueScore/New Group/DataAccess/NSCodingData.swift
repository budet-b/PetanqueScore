//
//  NSCodingData.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 17/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

class NSCodingData {
    static public func Save(profiles: [User]) -> Bool {
        return NSKeyedArchiver.archiveRootObject(profiles, toFile: User.ArchiveURL.path)
    }
    
    static public func GetProfils() -> [User]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: User.ArchiveURL.path) as? [User]
    }
    static public func SaveGame(games: [Game]) -> Bool {
        return NSKeyedArchiver.archiveRootObject(games, toFile: Game.ArchiveURL.path)
    }
    
    static public func GetGames() -> [Game]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Game.ArchiveURL.path) as? [Game]
    }
}

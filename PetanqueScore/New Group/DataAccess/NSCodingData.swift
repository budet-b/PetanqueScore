//
//  NSCodingData.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 17/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

class NSCodingData {
    public func Save(profile: User) -> Bool {
        let urlString = User.ArchiveURL.path
        return NSKeyedArchiver.archiveRootObject(profile, toFile: urlString)
    }
    
    public func GetProfils() -> [User]? {
        let urlString = User.ArchiveURL.absoluteString
        return NSKeyedUnarchiver.unarchiveObject(withFile: urlString) as? [User]
    }
}

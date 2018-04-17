//
//  NSCodingData.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 17/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

class NSCodingData {
    public func SaveProfils(profils: [User]) {
        let urlString = User.ArchiveURL.absoluteString
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(profils, toFile: urlString)
        if isSuccessfulSave {
            print("Success")
        } else {
            print("Error for save")
        }
    }
    
    public func GetProfils() -> [User]? {
        let urlString = User.ArchiveURL.absoluteString
        return NSKeyedUnarchiver.unarchiveObject(withFile: urlString) as? [User]
    }
}

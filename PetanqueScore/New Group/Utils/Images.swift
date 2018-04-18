//
//  Images.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 18/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation
import UIKit

class ImageLoad {
    public static func loadImage(fileName: String) -> UIImage? {
        let fileURL = NSURL(fileURLWithPath: fileName)
        do {
            let imageData = try Data(contentsOf: fileURL as URL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
}


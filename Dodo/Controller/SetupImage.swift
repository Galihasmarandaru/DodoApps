//
//  SetupImage.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 29/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

//if let imageData = image.jpeg(.lowest) {
//    print(imageData.count)
//}

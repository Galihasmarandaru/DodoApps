//
//  People.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 18/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class People {
    var name: String?
    var address: String?
    var picture: UIImage?
    
    var statusActivity: Transfused!

    init() {}
    
    convenience init(name: String, address: String, picture: UIImage) {
        self.init()
        self.name = name
        self.address = address
        self.picture = picture
    }
    
    
}

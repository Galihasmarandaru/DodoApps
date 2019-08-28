//
//  People.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 18/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import MapKit

struct People {
    var name: String?
    var location: CLLocation?
    var picture: UIImage?
    var password: String?
    var phoneNumber: String?
    
    var statusActivity: Transfused!

    init() {}
    
    init(name: String, location: CLLocation, picture: UIImage) {
        self.init()
        self.name = name
        self.location = location
        self.picture = picture
    }
    
    
}

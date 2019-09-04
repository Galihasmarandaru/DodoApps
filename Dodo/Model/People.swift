//
//  People.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 18/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import MapKit
import CloudKit

class People: NSObject {
    var recordID: CKRecord.ID!
    var name: String?
    var location: CLLocation?
    var picture: UIImage?
    var password: String?
    var phoneNumber: String?
    var isDonor: Int64?
    
    var statusActivity: Transfused!

    override init() {}
    
    convenience init(name: String, location: CLLocation, picture: UIImage) {
        self.init()
        self.name = name
        self.location = location
        self.picture = picture
    }
    
    convenience init(recordName: CKRecord.ID) {
        self.init()
        self.recordID = recordName
    }
}

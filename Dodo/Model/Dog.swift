//
//  Dog.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 21/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation

class Dog {
    var dogName: String?
    var dogAge: Int64?
    var dogWeight: Int64?
    var dogRhesus: String?
    
    init(dogName: String, dogAge: Int64, dogWeight: Int64, dogRhesus: String) {
        self.dogName = dogName
        self.dogAge = dogAge
        self.dogWeight = dogWeight
        self.dogRhesus = dogRhesus
    }
}

class Donor: Dog, Transfused {
    func calculateTime(target: Bool) {
        //
    }
    
    func statusDonor(target: Bool) {
        //
    }
}

class Resepient: Dog {}

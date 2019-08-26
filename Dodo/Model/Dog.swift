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
    var dogAge: Int?
    var dogWeight: Int?
    var dogRhesus: Int?
    
    init(dogName: String, dogAge: Int, dogWeight: Int) {
        self.dogName = dogName
        self.dogAge = dogAge
        self.dogWeight = dogWeight
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

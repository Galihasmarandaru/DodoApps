//
//  cloudViewController.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 22/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import CloudKit

// Setting CloudKit
final class CloudViewController {
    
    var donorProfile = DonorTableViewController()

    static let pDatabase = CKContainer.default().publicCloudDatabase
    var dogsOwner = [CKRecord]()
    var dogs = [CKRecord]()
    
    // for save register data
    class func saveUserData(user: People) {
        let newRecord = CKRecord(recordType: "DogLover")
        newRecord.setValue(user.name, forKey: "name")
        newRecord.setValue(user.phoneNumber, forKey: "phoneNumber")
        newRecord.setValue(user.password, forKey: "password")
        
        pDatabase.save(newRecord) { (record, _) in
            guard record != nil else { return }
        }
    }
    
    // for checking auth
    class func fetchAuth(
        phone: String,
        completion: @escaping ([CKRecord]) -> Void){
        var recordFound = [CKRecord]()
        let query = CKQuery(recordType: "DogLover", predicate: NSPredicate(format: "phoneNumber = %@", phone))
        
        pDatabase.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else { return }
            recordFound = records
            completion(recordFound)
        }
    }
    
    // for save Dog
//    func saveDataDog(nameDog: String, dogAge: Int, dogWeight: Double, dogRhesus: String) {
//        let newRecord = CKRecord(recordType: "Dogs")
//        newRecord.setValue(dogs, forKey: "content")
//
//        pDatabase.save(newRecord) { (record, _) in
//            guard record != nil else { return }
//            print("Save record \(String(describing: record?.object(forKey: "content")))")
//        }
//    }
    
    // for show
//    @objc func queryDatabase() {
//        let query = CKQuery(recordType: "owner", predicate: NSPredicate(value: true))
//        
//        pDatabase.perform(query, inZoneWith: nil) { (records, _) in
//            guard let records = records else { return }
//            let sortedRecords = records.sorted(by: {$0.creationDate! > $1.creationDate!})
//            // akses the records pada notes
//            self.dogsOwner = sortedRecords
//            DispatchQueue.main.async {
//                // stop refresh saat ditarik
//                self.donorProfile.tableView.refreshControl?.endRefreshing()
//                self.donorProfile.tableView.reloadData()
//            }
//            
//        }
//    }
    
    
}

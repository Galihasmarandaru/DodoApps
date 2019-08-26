//
//  cloudViewController.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 22/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import CloudKit

// Setting CloudKit
class CloudViewController {

    let pDatabase = CKContainer.default().privateCloudDatabase
    var dogsOwner = [CKRecord]()
    
    // for save
    func saveDataOwner(name: String, address: String, picture: String) {
        let newRecord = CKRecord(recordType: "Owner")
        newRecord.setValue(dogsOwner, forKey: "content")
        
        pDatabase.save(newRecord) { (record, _) in
            guard record != nil else { return }
            print("Save record \(String(describing: record?.object(forKey: "content")))")
        }
    }
    
    // for show
    @objc func queryDatabase() {
        let query = CKQuery(recordType: "owner", predicate: NSPredicate(value: true))
        
        pDatabase.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else { return }
            let sortedRecords = records.sorted(by: {$0.creationDate! > $1.creationDate!})
            // akses the records pada notes
            self.dogsOwner = sortedRecords
            DispatchQueue.main.async {
                // stop refresh saat ditarik
//                self.tableView.refreshControl?.endRefreshing()
//                self.tableView.reloadData()
            }
            
        }
    }
}

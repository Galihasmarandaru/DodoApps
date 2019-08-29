//
//  ListDogViewController.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 21/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import CloudKit

class ListDogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//    var owner: People!
    
    @IBOutlet weak var nameProfilList: UILabel!
    
    var userName: String = ""
    var recordID: CKRecord.ID!
    
    @IBOutlet weak var tableView: UITableView!
    
    var cloudDog = CKContainer.default().privateCloudDatabase
    var dogList = [CKRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
//        print(recordID)
        
        let refreshControl = UIRefreshControl()
        //        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(dogDatabase), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        // Do any additional setup after loading the view.
//        dogDatabase()
        nameProfilList?.text = userName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dogDatabase()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogList.count
    }

    
    // for show dog
    @objc func dogDatabase(){

        let reference = CKRecord.Reference(recordID: recordID, action: .deleteSelf)
//        print(reference)
        let pred = NSPredicate(format: "ownerID == %@", reference)
//        print(pred)
        let query = CKQuery(recordType: "Dogs", predicate: pred)
//        let query = CKQuery(recordType: "Dogs", predicate: NSPredicate(value: true))
        
//        print(query)
        
//        let queryOperation = CKQueryOperation(query: query)
        
//        queryOperation.queryCompletionBlock = {(records, error) in
            self.cloudDog.perform(query, inZoneWith: nil) { [unowned self] records, _ in
                guard let records = records else { return }
                
//                print(records)
                //            guard let records = records else { return }
                //            let sortedRecords = records.sorted(by: {$0.creationDate! > $1.creationDate!})
                //            // akses the records pada notes
                //            self.dogsOwner = sortedRecords
                DispatchQueue.main.async {
                    //                 stop refresh saat ditarik
                    //                self.tableView.refreshControl?.endRefreshing()
                    self.dogList = records
                    self.tableView.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
//            }

            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ListDogTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ListDogTableViewCell else {
            fatalError("Not working")
        }
        
        let dog = dogList[indexPath.row]
        
        cell.dogName?.text = dog.value(forKey: "dogName") as? String
        //        cell.radiusLabel.text = donors.address
        //        cell.radiusLabel?.text = donors.object(forKey: "name") as? String
        
        return cell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

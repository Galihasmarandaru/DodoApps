//
//  DonorTableViewController.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 18/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import CloudKit

class DonorTableViewController: UIViewController{
    
//    var owner = [People]()
    
    var cloudOwner = CKContainer.default().privateCloudDatabase
    var donor = [CKRecord]()
    
//    var profilDonor = People()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(queryDatabase), for: .valueChanged)
        self.tableView.refreshControl = refreshControl

//        let distance = DistanceMapViewController()
//        
//        distance.checkLocationAuthorization()
//        print(distance.centerViewOnUserLocation())
        
//        let addButton = UIBarButtonItem(image: UIImage(named: "Logo Blood Hero"), style: .done, target: self, action: #selector(tapButton))
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        // custom button navigation
//        let button: UIButton = UIButton(type: .custom)
//        button.setImage(UIImage(named: "Logo Blood Hero"), for: .normal)
//        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
////        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        queryDatabase()
//        queryDatabase()
//        loadDonor()
    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
////        queryDatabase()
//    }
//
    @objc func tapButton() {
        print("youu tap!")
    }

    // MARK: - Table view data source
    
    
//    private func loadDonor() {
//        let photo1 = UIImage(named: "Dodo")
    
//        let donor1 = People(name: "Budi", address: , picture: photo1!)
        
//        donor += [donor1]
        
//    }
    
    // for show owner dog
    @objc func queryDatabase(){
        let query = CKQuery(recordType: "DogLover", predicate: NSPredicate(value: true))
        
//        let operation = CKQueryOperation(query: query)
        
//        var newOwner = [People]()
        
//        operation.recordFetchedBlock = { record in
//            let own = People()
//            own.recordID = record.recordID
//            newOwner.append(own)
//        }
        
         cloudOwner.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else { return }
//            guard let records = records else { return }
//            let sortedRecords = records.sorted(by: {$0.creationDate! > $1.creationDate!})
//            // akses the records pada notes
//            self.dogsOwner = sortedRecords
            DispatchQueue.main.async {
                //                 stop refresh saat ditarik
//                self.tableView.refreshControl?.endRefreshing()
                self.donor = records
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let detailViewController = segue.destination as? ListDogViewController,
//            let index = tableView.indexPathForSelectedRow?.row
//            else {
//                return
//        }
//        detailViewController.donorOwner = profilDonor[index]
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.destination is ListDogViewController {
//            let vc = segue.destination as? ListDogViewController
//
//            vc?.userName = profilDonor.name!
//        }
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        let profilDonor = storyboard?.instantiateViewController(withIdentifier: "ListDogViewController") as! ListDogViewController
//
//        profilDonor.ownerName = donor[indexPath.row]
//    }
}

extension DonorTableViewController: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "DonorTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DonorTableViewCell else {
            fatalError("Not working")
        }
        
        let donors = donor[indexPath.row]
        
        cell.nameLabel?.text = donors.value(forKey: "name") as? String
        cell.chatButton.phoneNumber = donors.value(forKey: "phoneNumber") as! String
        //cell.radiusLabel.text = donors.address
        //cell.radiusLabel?.text = donors.object(forKey: "name") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donor.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let vc = ListDogViewController()
        
        let donors = donor[indexPath.row]
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListDogView") as? ListDogViewController {            
            
//            owner.append(People(recordName: donors.recordID))
            viewController.recordID = donors.recordID
            
            viewController.userName = (donors.value(forKey: "name") as? String)!
            
//            let name = viewController.userName
            
//            let query = CKQuery(recordType: "Dogs", predicate: NSPredicate(value: true))
//
//            cloudOwner.perform(query, inZoneWith: nil) { (records, _) in
//
////                let v = CKRecord.Reference(record: <#T##CKRecord#>, action: <#T##CKRecord_Reference_Action#>)
//
//
////                if name == records["ownerID"] {
////
////                }
//            }

            
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
}

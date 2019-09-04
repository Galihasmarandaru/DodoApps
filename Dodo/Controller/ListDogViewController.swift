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
    
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var imageOwn: UIImageView!
    @IBOutlet weak var nameProfilList: UILabel!
    
    var userName: String = ""
    var imageOwner: UIImage!
    var recordID: CKRecord.ID!
    
    @IBOutlet weak var tableView: UITableView!
    
    var cloudDog = CKContainer.default().publicCloudDatabase
    var dogList = [CKRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
                
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(dogDatabase), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        nameProfilList?.text = userName
        
        imageOwn.layer.cornerRadius = imageOwn.frame.height/2
        imageOwn?.image = imageOwner
        
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

        let pred = NSPredicate(format: "ownerID == %@", reference)

        let query = CKQuery(recordType: "Dogs", predicate: pred)

            self.cloudDog.perform(query, inZoneWith: nil) { [unowned self] records, _ in
                guard let records = records else { return }
                DispatchQueue.main.async {
                    self.dogList = records
                    self.tableView.refreshControl?.endRefreshing()
                    if self.dogList.count != 0 {
                        self.noDataView.isHidden = true
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                    } else {
                        self.noDataView.isHidden = false
                        self.tableView.isHidden = true
                    }
                    
                }            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ListDogTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ListDogTableViewCell else {
            fatalError("Not working")
        }
        
        let dog = dogList[indexPath.row]
        
        cell.dogName?.text = dog.value(forKey: "dogName") as? String
        
        if let asset = dog.value(forKey: "dogImage") as? CKAsset,
            let data = try? Data(contentsOf: asset.fileURL!)
        {
            cell.dogImage.image = UIImage(data: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}

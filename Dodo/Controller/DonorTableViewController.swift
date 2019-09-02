//
//  DonorTableViewController.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 18/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import CloudKit
import SwiftyDropbox

class DonorTableViewController: UIViewController{
    
    var cloudOwner = CKContainer.default().privateCloudDatabase
    var donor = [CKRecord]()
    
    var distance = DistanceMapViewController()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(queryDatabase), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
//        var donorTableCell = DonorTableViewCell()
//        donorTableCell.imageDonor.layer.cornerRadius = donorTableCell.imageDonor.frame.height/2
        

        queryDatabase()

    }
    @objc func tapButton() {
        print("youu tap!")
    }

    // MARK: - Table view data source
    
    // for show owner dog
    @objc func queryDatabase(){
        let query = CKQuery(recordType: "DogLover", predicate: NSPredicate(value: true))
        
         cloudOwner.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else { return }

            DispatchQueue.main.async {
                self.donor = records
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
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
        
//        DispatchQueue.global(qos: .background).async {
            cell.nameLabel?.text = donors.value(forKey: "name") as? String
//        }
//        cell.radiusLabel?.text = distance.getDistance(donorLocation: donors.value(forKey: "location") as! CLLocation)
        
            cell.imageDonor.layer.cornerRadius = cell.imageDonor.frame.height/2
//        DispatchQueue.global(qos: .background).async {
            if let asset = donors.value(forKey: "image") as? CKAsset,
                let data = try? Data(contentsOf: asset.fileURL!)
            {
                cell.imageDonor.image = UIImage(data: data)
            }
//        }

//        cell.imageDonor.image = donors.value(forKey: "image") as? UIImage
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
            
            viewController.recordID = donors.recordID
            
            viewController.userName = (donors.value(forKey: "name") as? String)!
//            viewController.imageOwner = (donors.value(forKey: "image") as? UIImage)!
            
//            cell.imageDonor.layer.cornerRadius = cell.imageDonor.frame.height/2        
            
            if let asset = donors.value(forKey: "image") as? CKAsset,
                let data = try? Data(contentsOf: asset.fileURL!)
            {
                viewController.imageOwner = UIImage(data: data)
            }


            
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func myButtonInControllerPressed() {
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                      controller: self,
                                                      openURL: { (url: URL) -> Void in
                                                        UIApplication.shared.openURL(url)
        })
    }
}

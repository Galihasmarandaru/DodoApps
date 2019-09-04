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
    
    var cloudOwner = CKContainer.default().publicCloudDatabase
    var donor = [CKRecord]()
    
    var distance = DistanceMapViewController()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(queryDatabase), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableFooterView = UIView()
        
        distance.checkLocationServices()
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
        
            cell.nameLabel?.text = donors.value(forKey: "name") as? String
        
            cell.imageDonor.layer.cornerRadius = cell.imageDonor.frame.height/2

            if let asset = donors.value(forKey: "image") as? CKAsset,
                let data = try? Data(contentsOf: asset.fileURL!)
            {
                cell.imageDonor.image = UIImage(data: data)
            }
        
        let location = distance.getDistance(donorLocation: (donors.value(forKey: "location") as? CLLocation)!)
        
        cell.radiusLabel.text = location

        cell.chatButton.phoneNumber = donors.value(forKey: "phoneNumber") as! String
        
        cell.chatButtonAction = { [unowned self] in
            if AuthController.isSignedIn
            {
                let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=62" + cell.chatButton.phoneNumber + "&text=hello%20boi")
                if UIApplication.shared.canOpenURL(whatsappURL!) {
                    UIApplication.shared.open(whatsappURL!, options: .init(), completionHandler: nil)
                }
            }
            else
            {
                NavigationController.navigate(vc: self, storyboard: "Authentication", to: "registerVC")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donor.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let donors = donor[indexPath.row]
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListDogView") as? ListDogViewController {            
            
            viewController.recordID = donors.recordID
            
            viewController.userName = (donors.value(forKey: "name") as? String)!

            
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

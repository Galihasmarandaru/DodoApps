//
//  ProfileTableViewController.swift
//  Dodo
//
//  Created by Gregory Kevin on 23/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import CloudKit

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var profilePictureButton: UIButton!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet var profileTableView: UITableView!
    
    var cloud = CKContainer.default().privateCloudDatabase
    var dogLover = [CKRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = CKQuery(recordType: "DogLover", predicate: NSPredicate(value: true))
        
        cloud.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else { return }
            //            guard let records = records else { return }
            //            let sortedRecords = records.sorted(by: {$0.creationDate! > $1.creationDate!})
            //            // akses the records pada notes
            //            self.dogsOwner = sortedRecords
            
            DispatchQueue.main.async {
                for record in records {
                    self.profileNameLabel.text = record["name"]!
                    
//                    self.phoneTextField.text = record["phoneNumber"]!
//
//                    self.locationLabel.text = record["location"]!
                }
            }
//            DispatchQueue.main.async {
//                //                 stop refresh saat ditarik
//                //                self.tableView.refreshControl?.endRefreshing()
//                self.dogLover = records
//
//            }
        }

        
        profilePictureButton.layer.masksToBounds = true
        profilePictureButton.layer.cornerRadius = profilePictureButton.bounds.width / 2

        
        profileTableView.tableFooterView = UIView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func donorButtonPressed(_ sender: UIButton) {
        //
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
        //
    }
    
    
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  DogListProfileTableViewController.swift
//  Dodo
//
//  Created by Gregory Kevin on 26/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class DogListProfileTableViewController: UITableViewController {

    @IBOutlet var dogListTableView: UITableView!
    
    var dogs: [Donor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadDogs()
        dogListTableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dogs.count
    }
    
    func loadDogs() {
        let dog = Donor.init(dogName: "Axel", dogAge: 3, dogWeight: 23, dogRhesus: "Positive")
        let dog1 = Donor.init(dogName: "aaaa", dogAge: 4, dogWeight: 44, dogRhesus: "Positive")
        let dog2 = Donor.init(dogName: "bbb", dogAge: 5, dogWeight: 55, dogRhesus: "Positive")
        dogs.append(dog)
        dogs.append(dog1)
        dogs.append(dog2)
        dogs.append(dog)
        dogs.append(dog1)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "DogListTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DogListTableViewCell else {
            fatalError("Not working")
        }
        
        let dogss = dogs[indexPath.row]
    
        cell.dogName.text = dogss.dogName
        cell.dogAge.text = "\(dogss.dogAge!)"
        cell.dogWeight.text = "\(dogss.dogWeight!)"
        cell.dogBloodType.text = "Positive"
            
        return cell
    }    

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

//
//  DonorTableViewController.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 18/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class DonorTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var donor = [People]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let distance = DistanceMapViewController()
//        
//        distance.checkLocationAuthorization()
//        print(distance.centerViewOnUserLocation())
        
//        let addButton = UIBarButtonItem(image: UIImage(named: "Logo Blood Hero"), style: .done, target: self, action: #selector(tapButton))
        
        // custom button navigation
        let button: UIButton = UIButton(type: .custom)
        button.setImage(UIImage(named: "Logo Blood Hero"), for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
//        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        loadDonor()
    }
    
    @objc func tapButton() {
        print("youu tap!")
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donor.count
    }
    
    private func loadDonor() {
        let photo1 = UIImage(named: "Dodo")
        
        let donor1 = People(name: "Budi", address: "Jalan Jamu", picture: photo1!)
        
        donor += [donor1]
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "DonorTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DonorTableViewCell else {
            fatalError("Not working")
        }
        
        let donors = donor[indexPath.row]
        
        cell.nameLabel.text = donors.name
        cell.radiusLabel.text = donors.address
        cell.imageDonor.image = donors.picture

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let profilDonor = storyboard?.instantiateViewController(withIdentifier: "ListDogViewController") as! ListDogViewController

        profilDonor.ownerName = donor[indexPath.row]
    }
}

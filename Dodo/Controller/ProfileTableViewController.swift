//
//  ProfileTableViewController.swift
//  Dodo
//
//  Created by Gregory Kevin on 23/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import CloudKit
import CoreData


class ProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var profilePictureButton: UIButton!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet var profileTableView: UITableView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var beDonorBtn: UIButton!
    
    var cloud = CKContainer.default().publicCloudDatabase
    var dogLover = [CKRecord]()
    
    var owner : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileTableView.delegate = self
        
        if AuthController.isSignedIn
        {
            
            profilePictureButton.layer.masksToBounds = true
            profilePictureButton.layer.cornerRadius = profilePictureButton.bounds.width / 2
            
            
            profileTableView.tableFooterView = UIView()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if AuthController.isSignedIn
        {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DogLover")
            
            do {
                owner = try managedContext.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            
            let phoneNumber = owner[0].value(forKey: "phoneNumber") as! String
            
            CloudViewController.fetchAuth(phone: phoneNumber) { (result) in
                DispatchQueue.main.async {
                    self.profileNameLabel.text = result[0].value(forKey: "name") as! String
                    self.phoneTextField.text = phoneNumber
                    
                    if result[0].value(forKey: "isDonor") as! Int64 == 1
                    {
                        self.beDonorBtn.isHidden = true
                    }
                }
            }
        }
    }
    
    @IBAction func donorButtonPressed(_ sender: UIButton) {
        if let viewController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "newDogTableVC") as? NewDogTableViewController
        {
            viewController.phone = owner[0].value(forKey: "phoneNumber") as! String
            
//            self.present(viewController, animated: false, completion: nil)
        }
        
        
    }
    
    @IBAction func profilePictureButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            
            profilePictureImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try AuthController.signOut()
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DogLover")
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let results = try managedContext.fetch(fetchRequest)
                for object in results {
                    guard let objectData = object as? NSManagedObject else {continue}
                    managedContext.delete(objectData)
                }
            } catch let error {
                print("Detele all data in DogLover error :", error)
            }
            
            
            NavigationController.changeRoot(vc: self, storyboard: "Authentication", to: "loginVC")
        } catch  {
            print("Gagal logout")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                
//                let vc = DistanceMapViewController()
//                self.navigationController?.pushViewController(vc, animated: true)
//                self.present(vc, animated: true, completion: nil)
                let viewController:UIViewController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "DistanceMapViewController") as! DistanceMapViewController
                // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
                
                self.present(viewController, animated: true, completion: nil)
                tableView.deselectRow(at: IndexPath.init(row: 0, section: 2), animated: true)
            }
        }
        
    }
}

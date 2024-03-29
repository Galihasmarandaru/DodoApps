//
//  NewDogTableViewController.swift
//  Dodo
//
//  Created by Gregory Kevin on 23/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import CloudKit

class NewDogTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var dogProfilePictureImageView: UIImageView!
    @IBOutlet weak var dogPictureButton: UIButton!
    @IBOutlet weak var dogNameTextField: UITextField!
    @IBOutlet weak var dogAgeTextField: UITextField!
    @IBOutlet weak var dogWeightTextField: UITextField!
    @IBOutlet weak var dogBloodTypeTextField: UITextField!
    @IBOutlet weak var dogLastDonorTextField: UITextField!
    @IBOutlet weak var uploadVaccineBookButton: UIButton!
    @IBOutlet weak var vaccineBookImageView: UIImageView!
    @IBOutlet weak var vaccineBookButton: UIButton!
    @IBOutlet weak var newDogTableView: UITableView!
    @IBOutlet weak var vaccineBookView: UIView!
    
    var phone : String?
    
    var cloudDog = CKContainer.default().publicCloudDatabase
    
    let viewPicker = UIPickerView()
    var dogAgePickerData: [String] = [String]()
    var dogWeightPickerData: [String] = [String]()
    var dogBloodTypePickerData: [String] = [String]()
    
    var dog: Donor? = nil
    
    var dogName = ""
    var dogAge: Int64?
    var dogWeight: Int64?
    var dogBloodType = ""
    var dogLastDonor = ""
    var temp = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dogPictureButton.layer.masksToBounds = true
        dogPictureButton.layer.cornerRadius = dogPictureButton.bounds.width / 2
        
        dogProfilePictureImageView.layer.masksToBounds = true
        dogProfilePictureImageView.layer.cornerRadius = dogProfilePictureImageView.bounds.width / 2
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func vaccineBookButtonPressed(_ sender: Any) {
        temp = 1
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
    
    @IBAction func dogPictureButtonPressed(_ sender: Any) {
        temp = 0
        
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
            if temp == 0 {
                dogProfilePictureImageView.image = pickedImage
            }
            else {
                vaccineBookImageView.image = pickedImage
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func setDogWeightPicker() {
        for i in 20...80 {
            dogWeightPickerData.append("\(i)")
        }
        dogWeightTextField.inputView = viewPicker
        viewPicker.delegate = self
    }
    
    func setDogAgePicker() {
        dogAgePickerData = ["2","3","4","5","6","7"]
        
        dogAgeTextField.inputView = viewPicker
        viewPicker.delegate = self
    }
    
    func setDogBloodTypePicker() {
        dogBloodTypePickerData = ["Haven't checked yet", "Positive", "Negative"]
        
        dogBloodTypeTextField.inputView = viewPicker
        viewPicker.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if dogAgeTextField.isEditing == true {
            return dogAgePickerData.count
        }
        else if dogWeightTextField.isEditing == true {
            return dogWeightPickerData.count
        }
        else {
            return dogBloodTypePickerData.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if dogAgeTextField.isEditing == true {
            return dogAgePickerData[row]
        }
        else if dogWeightTextField.isEditing == true {
            return dogWeightPickerData[row]
        }
        else {
            return dogBloodTypePickerData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if dogAgeTextField.isEditing == true {
            dogAgeTextField.text = dogAgePickerData[row]
        }
        else if dogWeightTextField.isEditing == true {
            dogWeightTextField.text = dogWeightPickerData[row]
        }
        else {
            dogBloodTypeTextField.text = dogBloodTypePickerData[row]
        }
    }
    
    @IBAction func dogAgeEditingDidBegin(_ sender: UITextField) {
        setDogAgePicker()
    }
    
    @IBAction func dogWeightEditingDidBegin(_ sender: UITextField) {
        setDogWeightPicker()
    }
    
    @IBAction func dogBloodTypeEditingDidBegin(_ sender: UITextField) {
        setDogBloodTypePicker()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if dogNameTextField.text == "" {
            showErrorAlert(errorTitle: "Error", errorMessage: "Dog name must be filled!")
        }
        else if dogAgeTextField.text == "" {
            showErrorAlert(errorTitle: "Error", errorMessage: "Dog age must be chosen!")
        }
        else if dogWeightTextField.text == "" {
            showErrorAlert(errorTitle: "Error", errorMessage: "Dog weight must be chosen!")
        }
        else if dogBloodTypeTextField.text == "" {
            showErrorAlert(errorTitle: "Error", errorMessage: "Dog blood type must be chosen!")
        }
        else {
            
            let dogs = CKRecord(recordType: "Dogs")
            
            dogName = dogNameTextField.text as CKRecordValue? as! String
            dogAge = dogAgeTextField.text as CKRecordValue? as? Int64
            dogWeight = dogWeightTextField.text as CKRecordValue? as? Int64
            dogBloodType = dogBloodTypeTextField.text as CKRecordValue? as! String
            
            dogs.setObject(dogName as __CKRecordObjCValue, forKey: "dogName")
            dogs.setObject(dogAge as __CKRecordObjCValue?, forKey: "dogAge")
            dogs.setObject(dogWeight as __CKRecordObjCValue?, forKey: "dogWeight")
            dogs.setObject(dogBloodType as __CKRecordObjCValue, forKey: "dogRhesus")
            
            dog = Donor.init(dogName: dogName, dogAge: dogAge ?? 0, dogWeight: dogWeight ?? 0, dogRhesus: dogBloodType)
            
            cloudDog.save(dogs) { (record, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print(error)
                    } else {
                        print("Record saved")
                    }
                }
            }
            
            CloudViewController.fetchAuth(phone: phone!) { (result) in
                result[0].setValue(1, forKey: "isDonor")
                
                self.cloudDog.save(result[0]){ (record, _) in
                }
            }
            
//            performSegue(withIdentifier: "goToProfileBeADonor", sender: self)
        }
    }
    
    func showErrorAlert(errorTitle: String, errorMessage: String) {
        let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.destination is ProfileBeADonorTableViewController {
//            let vc = segue.destination as? ProfileBeADonorTableViewController
//            vc?.dogList.append(dog!)
//        }
//    }
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

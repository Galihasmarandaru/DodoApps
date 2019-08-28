//
//  LoginController.swift
//  Dodo
//
//  Created by Frederic Orlando on 22/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import CoreData

class LoginController: UIViewController {

    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var phoneErr: UILabel!
    
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var passErr: UILabel!
    
    let loadingContainer = UIView()
    
    private enum TextFieldTag: Int
    {
        case phone
        case password
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        phoneTxt.delegate = self
        phoneTxt.tag = TextFieldTag.phone.rawValue
        
        passTxt.delegate = self
        passTxt.tag = TextFieldTag.password.rawValue
        
        phoneErr.textColor = .clear
        passErr.textColor = .clear
        
        loadingContainer.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleAuthState),
            name: .loginStatusChanged,
            object: nil
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if AuthController.isSignedIn
        {
            //navigateProfile()
        }
    }
    
    @objc func handleAuthState()
    {
        if AuthController.isSignedIn
        {
            print("User logged in")
            NavigationController.navigate(vc: self, storyboard: "Main", to: "UITabBarController-LZ5-tm-lEc")
        }
        else
        {
            print("User not logged in")
        }
    }
    
    func startLoading()
    {
        let activityView = UIActivityIndicatorView(style: .gray)
        activityView.center = loadingContainer.center
        
        loadingContainer.addSubview(activityView)
        
        activityView.translatesAutoresizingMaskIntoConstraints = false
        //activityView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //activityView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        activityView.centerXAnchor.constraint(equalTo: loadingContainer.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: loadingContainer.centerYAnchor).isActive = true
        
        view.addSubview(loadingContainer)
        
        loadingContainer.translatesAutoresizingMaskIntoConstraints = false
        loadingContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        loadingContainer.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        loadingContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loadingContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        activityView.startAnimating()
        print("start loading")
    }
    
    func stopLoading()
    {
        print("stop loading")
        
        for view in loadingContainer.subviews
        {
            view.removeFromSuperview()
        }
        loadingContainer.removeFromSuperview()
        print("finish loading")
    }
    
    private func signIn()
    {
        self.phoneErr.textColor = .clear
        self.passErr.textColor = .clear
        
        startLoading()
        
        view.endEditing(true)
        
        let salt = "xhakgl1m4jl0kal8=gma0.m"
        
        guard let phone = phoneTxt.text, phone.count > 0 else
        {return}
        
        guard let password = passTxt.text, password.count > 0 else
        {return}
        
        CloudViewController.fetchAuth(phone: phone, completion: {(result) in
            print(result.count)
            if result.count > 0 //ada data dengan no hape yg sama
            {
                print("\(password).\(salt)".sha256())
                if "\(password).\(salt)".sha256() == result[0].value(forKey: "password") as! String
                {
                    let deviceName = UIDevice.current.name
                    let user = User(deviceName: deviceName, phone: phone)
                    
                    do {
                        try AuthController.signIn(user, password: password)
                    } catch{
                        print("Error signing in: \(error.localizedDescription)")
                    }
                }
                else //pass salah
                {
                    DispatchQueue.main.async {
                        self.passErr.textColor = .ErrorRed
                        self.passErr.text = "Incorrect Password"
                    }
                }
            }
            else // user not exist
            {
                print("user not exist")
                let errorText = "User does not exist"
                
                DispatchQueue.main.async {
                    self.phoneErr.textColor = .ErrorRed
                    self.passErr.textColor = .ErrorRed
                    
                    self.phoneErr.text = errorText
                    self.passErr.text = errorText
                }
            }
            DispatchQueue.main.async {
                self.stopLoading()
            }
        })
    }
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        signIn()
    }
    
    func saveOwnerID(id: String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        user.setValue(id, forKey: "ownerId")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

extension LoginController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count > 0 else
        {
            return false
        }
        
        switch textField.tag {
        case TextFieldTag.phone.rawValue:
            passTxt.becomeFirstResponder()
        case TextFieldTag.password.rawValue:
            signIn()
        default:
            return false
        }
        
        return true
    }
}

//
//  LoginController.swift
//  Dodo
//
//  Created by Frederic Orlando on 22/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var phoneErr: UILabel!
    
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var passErr: UILabel!
    
    private enum TextFieldTag: Int
    {
        case phone
        case password
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        phoneTxt.delegate = self
        phoneTxt.tag = TextFieldTag.phone.rawValue
        
        passTxt.delegate = self
        passTxt.tag = TextFieldTag.password.rawValue
        
        phoneErr.textColor = .clear
        passErr.textColor = .clear
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
            navigateProfile()
        }
    }
    
    func navigateProfile()
    {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let profile = main.instantiateViewController(withIdentifier: "UITabBarController-LZ5-tm-lEc")
        
        self.present(profile, animated: false, completion: nil)
    }
    
    @objc func handleAuthState()
    {
        if AuthController.isSignedIn
        {
            print("User logged in")
            navigateProfile()
        }
        else
        {
            print("User not logged in")
        }
    }
    
    private func signIn()
    {
        self.phoneErr.textColor = .clear
        self.passErr.textColor = .clear
        
        view.endEditing(true)
        
        let salt = "xhakgl1m4jl0kal8=gma0.m"
        
        guard let phone = phoneTxt.text, phone.count > 0 else
        {return}
        
        guard let password = passTxt.text, password.count > 0 else
        {return}
        
        CloudViewController.fetchAuth(phone: phone, completion: {(result) in
            print(result)
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
                else
                {
                    self.passErr.textColor = .ErrorRed
                }
            }
            else
            {
                self.phoneErr.textColor = .ErrorRed
                self.passErr.textColor = .ErrorRed
            }
        })
    }
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        signIn()
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

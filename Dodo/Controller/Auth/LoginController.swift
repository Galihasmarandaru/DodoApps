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
        phoneErr.textColor = .ErrorRed
        passErr.textColor = .ErrorRed
        
        view.endEditing(true)
        
        let dummyPhone = "0859"
        let dummyPass = "abcdef"
        
        let salt = "xhakgl1m4jl0kal8=gma0.m"
        let dummyPassHash = "\(dummyPass).\(salt)".sha256()
        
        guard let phone = phoneTxt.text, phone.count > 0 else
        {return}
        
        guard let password = passTxt.text, password.count > 0 else
        {return}
        
        if phone == dummyPhone && "\(password).\(salt)".sha256() == dummyPassHash
        {
            let deviceName = UIDevice.current.name
            let user = User(deviceName: deviceName, phone: phone)
            
            do {
                try AuthController.signIn(user, password: password)
            } catch{
                print("Error signing in: \(error.localizedDescription)")
            }
        }
        
        phoneErr.textColor = (phone == dummyPhone) ? .clear : .ErrorRed
        passErr.textColor = (password == dummyPass) ? .clear : .ErrorRed
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

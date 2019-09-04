//
//  RegisterViewController.swift
//  Dodo
//
//  Created by Frederic Orlando on 22/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var nameErr: UILabel!
    
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var phoneErr: UILabel!
    
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var passErr: UILabel!
    
    @IBOutlet weak var cpassTxt: UITextField!
    @IBOutlet weak var cpassErr: UILabel!
    
    private enum TextFieldTag: Int
    {
        case name
        case phone
        case password
        case cpassword
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        nameTxt.delegate = self
        nameTxt.tag = TextFieldTag.name.rawValue
        
        phoneTxt.delegate = self
        phoneTxt.tag = TextFieldTag.phone.rawValue
        
        passTxt.delegate = self
        passTxt.tag = TextFieldTag.password.rawValue
        
        cpassTxt.delegate = self
        cpassTxt.tag = TextFieldTag.cpassword.rawValue
        
        nameErr.reset()
        phoneErr.reset()
        passErr.reset()
        cpassErr.reset()
        
//        nameErr.textColor = .ErrorRed
//        phoneErr.textColor = .ErrorRed
//        passErr.textColor = .ErrorRed
//        cpassErr.textColor = .ErrorRed
    }

    func isPasswordEqual() -> Bool
    {
        let isPasswordEqual = passTxt.text == cpassTxt.text
        
        return isPasswordEqual
    }
    
    func isUserExist(completion: @escaping (Bool) -> Void)
    {
        CloudViewController.fetchAuth(phone: self.phoneTxt.text!, completion: {(result) in
            let isUserExist = result.count > 0 ? true : false
            
            DispatchQueue.main.async {
                completion(isUserExist)
            }
        })
    }
    
    func isDataValid(completion: @escaping (Bool) -> Void)
    {
        isUserExist(completion: { (result) in
            if result || !self.isPasswordEqual()
            {
                if result
                {
                    DispatchQueue.main.async {
                        
                        self.phoneErr.text = "User exists"
                        self.phoneErr.textColor = .ErrorRed
                    }
                }
                
                DispatchQueue.main.async {
                    if !self.isPasswordEqual()
                    {
                        let errorText = "Different password"
                        
                        self.passErr.text = errorText
                        self.passErr.textColor = .ErrorRed
                        
                        self.cpassErr.text = errorText
                        self.cpassErr.textColor = .ErrorRed
                    }
                }
                DispatchQueue.main.async {
                    completion(false)
                }
            }
            else
            {
                DispatchQueue.main.async {
                    completion(true)
                }
            }
        })
    }
    
    func signUp()
    {
        
        nameErr.reset()
        phoneErr.reset()
        passErr.reset()
        cpassErr.reset()
        
        if phoneTxt.text!.count == 0 || nameTxt.text!.count == 0 || passTxt.text!.count == 0
        {
            let errorText  = "Must be filled"
            
            if phoneTxt.text!.count == 0
            {
                phoneErr.text = errorText
                phoneErr.textColor = .ErrorRed
            }
            
            if nameTxt.text!.count == 0
            {
                nameErr.text = errorText
                nameErr.textColor = .ErrorRed
            }
            
            if passTxt.text!.count == 0
            {
                passErr.text = errorText
                passErr.textColor = .ErrorRed
            }
            
            return
        }

        //put sign up func here
        isDataValid(completion: { (result) in
            if result
            {
                DispatchQueue.main.async {
                    let salt = "xhakgl1m4jl0kal8=gma0.m"
                    let user = People()
                    
                    let password : String = self.passTxt.text!
                    
                    user.name = self.nameTxt.text
                    user.phoneNumber = self.phoneTxt.text
                    user.password = "\(password).\(salt)".sha256()
                    user.isDonor = 0
                    
                    
                    CloudViewController.saveUserData(user: user)
                    
                    print("regis")
                    
                    NavigationController.navigate(vc: self, storyboard: "Authentication", to: "loginVC")
                }
            }
        })
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        signUp()
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        NavigationController.navigateToHome(vc: self)
    }
    
}

extension RegisterViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count > 0 else
        {
            return false
        }
        
        switch textField.tag {
        case TextFieldTag.name.rawValue:
            phoneTxt.becomeFirstResponder()
        case TextFieldTag.phone.rawValue:
            passTxt.becomeFirstResponder()
        case TextFieldTag.password.rawValue:
            cpassTxt.becomeFirstResponder()
        case TextFieldTag.cpassword.rawValue:
            signUp()
        default:
            return false
        }
        
        return true
    }
}

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

        nameTxt.delegate = self
        nameTxt.tag = TextFieldTag.name.rawValue
        
        phoneTxt.delegate = self
        phoneTxt.tag = TextFieldTag.phone.rawValue
        
        passTxt.delegate = self
        passTxt.tag = TextFieldTag.password.rawValue
        
        cpassTxt.delegate = self
        cpassTxt.tag = TextFieldTag.cpassword.rawValue
        
        nameErr.textColor = .clear
        phoneErr.textColor = .clear
        passErr.textColor = .clear
        cpassErr.textColor = .clear
    }

    func validate() -> Bool
    {
        
        
        let isPasswordEqual = passTxt.text == cpassTxt.text
        passErr.textColor = isPasswordEqual ? .clear : .ErrorRed
        cpassErr.textColor = isPasswordEqual ? .clear : .ErrorRed
        
        return isPasswordEqual
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        //put sign up func here
        if validate()
        {
            print("regis")
        }
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
            nameTxt.becomeFirstResponder()
        case TextFieldTag.phone.rawValue:
            passTxt.becomeFirstResponder()
        case TextFieldTag.password.rawValue:
            cpassTxt.becomeFirstResponder()
        case TextFieldTag.cpassword.rawValue:
            print("Cpassword")
        default:
            return false
        }
        
        return true
    }
}

//
//  AuthController.swift
//  Dodo
//
//  Created by Frederic Orlando on 22/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import CryptoSwift

final class AuthController
{
    static let serviceName = "DodoService"
    static var isSignedIn: Bool
    {
        guard let currentUser = Settings.currentUser else
        {
            return false
        }
        do
        {
            let password  = try KeychainManager(service: serviceName, account: currentUser.phone).readPassword()
            print("ada password")
            return password.count > 0
        }
        catch
        {
            return false
        }
    }
    
    class func passwordHash(from email: String, password: String) -> String
    {
        let salt = "xhakgl1m4jl0kal8=gma0.m"
        return "\(password).\(salt)".sha256()
    }
    
    class func signIn(_ user: User, password: String) throws
    {
        let finalHash = passwordHash(from: user.phone, password: password)
        try KeychainManager(service: serviceName, account: user.phone).savePassword(finalHash)
        Settings.currentUser = user
        NotificationCenter.default.post(name: .loginStatusChanged, object: nil)
    }
    
    class func signOut() throws
    {
        guard let currentUser = Settings.currentUser else
        {return}
        
        try KeychainManager(service: serviceName, account: currentUser.phone).deleteItem()
        
        Settings.currentUser = nil
        NotificationCenter.default.post(name: .loginStatusChanged, object: nil)
    }
}

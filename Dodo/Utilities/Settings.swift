//
//  Settings.swift
//  Dodo
//
//  Created by Frederic Orlando on 22/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation

final class Settings
{
    private enum Keys: String
    {
        case user = "current_user"
    }
    
    static var currentUser: User?
    {
        get
        {
            guard let data = UserDefaults.standard.data(forKey: Keys.user.rawValue) else{
                return nil
            }
            return try? JSONDecoder().decode(User.self, from: data)
        }
        
        set
        {
            if let data = try? JSONEncoder().encode(newValue)
            {
                UserDefaults.standard.set(data, forKey: Keys.user.rawValue)
            }
            else
            {
                UserDefaults.standard.removeObject(forKey: Keys.user.rawValue)
            }
            UserDefaults.standard.synchronize()
        }
    }
}

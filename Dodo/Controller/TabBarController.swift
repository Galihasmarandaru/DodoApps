//
//  TabBarController.swift
//  Dodo
//
//  Created by Frederic Orlando on 31/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 1
        {
            if !AuthController.isSignedIn
            {
                NavigationController.changeRoot(vc: viewController, storyboard: "Authentication", to: "registerVC")
            }
        }
    }

}

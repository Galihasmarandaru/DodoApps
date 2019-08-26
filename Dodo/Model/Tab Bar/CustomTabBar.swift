//
//  CustomTabBar.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 20/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBarItem {
    override func awakeFromNib() {
        self.selectedImage = UIImage(named: "Logo Blood Hero")!.withRenderingMode(.alwaysOriginal)
    }
}

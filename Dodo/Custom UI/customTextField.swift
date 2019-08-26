//
//  customTextField.swift
//  Dodo
//
//  Created by Frederic Orlando on 23/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class customTextField: UITextField {
    let bottomBorder = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    
    func setupTextField()
    {
        //hide textfield border
        borderStyle = .none
        
        //create line as border
        self.addSubview(bottomBorder)
        bottomBorder.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 1)
        
        bottomBorder.backgroundColor = .black
    }
}

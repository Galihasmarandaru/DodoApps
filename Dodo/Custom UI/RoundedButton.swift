//
//  RoundedButton.swift
//  Dodo
//
//  Created by Frederic Orlando on 22/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton()
    {
        setTitleColor(.black, for: .normal)
        backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.6784313725, blue: 0.6078431373, alpha: 1)
        layer.cornerRadius = self.frame.height/3
        heightAnchor.constraint(equalToConstant: 60.0).isActive = true
    }
}

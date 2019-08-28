//
//  ListDogTableViewCell.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 28/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class ListDogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var dogName: UILabel!
    @IBOutlet weak var dogAge: UILabel!
    @IBOutlet weak var dogWeight: UILabel!
    @IBOutlet weak var dogRhesus: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

//
//  DonorTableViewCell.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 18/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class DonorTableViewCell: UITableViewCell{
    
    @IBOutlet weak var imageDonor: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var radiusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func chatAction(_ sender: Any) {
    }
    
    
}

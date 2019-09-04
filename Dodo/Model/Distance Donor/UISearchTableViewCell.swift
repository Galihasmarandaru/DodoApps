//
//  UISearchTableViewCell.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 03/09/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class UISearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

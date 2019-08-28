//
//  DogListTableViewCell.swift
//  Dodo
//
//  Created by Gregory Kevin on 26/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class DogListTableViewCell: UITableViewCell {

    @IBOutlet weak var dogName: UILabel!
    @IBOutlet weak var dogAge: UILabel!
    @IBOutlet weak var dogWeight: UILabel!
    @IBOutlet weak var dogBloodType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func availableSwitch(_ sender: Any) {
        
    }
}

//
//  DonorTableViewCell.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 18/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class DonorTableViewCell: UITableViewCell{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageDonor: UIImageView!
    
    @IBOutlet weak var radiusLabel: UILabel!
    @IBOutlet weak var chatButton: chatButton!
    
    var chatButtonAction : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.chatButton.addTarget(self, action: #selector(chatBtnPressed(_:)), for: .touchUpInside)
    }
    
    @IBAction func chatBtnPressed(_ sender: chatButton) {
        
        chatButtonAction?()
        
//        let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=62" + chatButton.phoneNumber + "&text=hello%20boi")
//        if UIApplication.shared.canOpenURL(whatsappURL!) {
//            //UIApplication.shared.openURL(whatsappURL!)
//            UIApplication.shared.open(whatsappURL!, options: .init(), completionHandler: nil)
//        }
    }
}

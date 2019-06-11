//
//  ContactTableViewCell.swift
//  contacts
//
//  Created by Веригин С.И. on 24/05/2019.
//  Copyright © 2019 Веригин С.И. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dobtel: UILabel!
    @IBOutlet weak var fio: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var photoProfile: UIImageView!
    @IBOutlet weak var phone: UILabel!
    var surnameArray = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Style PhotoProfile
        photoProfile.layer.borderWidth = 0.5
        photoProfile.layer.masksToBounds = false
        photoProfile.layer.borderColor = UIColor.white.cgColor
        photoProfile.layer.cornerRadius = photoProfile.frame.height/2
        photoProfile.clipsToBounds = true
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

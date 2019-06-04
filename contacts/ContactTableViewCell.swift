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
    @IBOutlet weak var FIO: UILabel!
    @IBOutlet weak var Position: UILabel!
    @IBOutlet weak var PhotoProfile: UIImageView!
    @IBOutlet weak var Phone: UILabel!
    var surnameArray = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Style PhotoProfile
        PhotoProfile.layer.borderWidth = 0.5
        PhotoProfile.layer.masksToBounds = false
        PhotoProfile.layer.borderColor = UIColor.white.cgColor
        PhotoProfile.layer.cornerRadius = PhotoProfile.frame.height/2
        PhotoProfile.clipsToBounds = true
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

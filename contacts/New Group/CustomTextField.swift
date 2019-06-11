//
//  CustomTextField.swift
//  contacts
//
//  Created by Веригин С.И. on 11/06/2019.
//  Copyright © 2019 Веригин С.И. All rights reserved.
//

import UIKit


// Style definition for TextField
class CustomTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.underlined()
    }
    
    func underlined() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x:0.0, y: self.frame.size.height - 1, width:
            self.frame.size.width,height: 0.3)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
        
    }
}

//
//  HeaderView.swift
//  contacts
//
//  Created by Веригин С.И. on 24/05/2019.
//  Copyright © 2019 Веригин С.И. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate {
    func toggleSection(header: HeaderView, section: Int)
}


class HeaderView: UITableViewHeaderFooterView {
    
    var delegate: HeaderViewDelegate?
    var section: Int?
    
    func setup(withTitle title: String, section: Int, delegate: HeaderViewDelegate) {
        
        self.delegate = delegate
        self.section = section
        self.textLabel?.text = title
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.textColor = .white
        contentView.backgroundColor = .darkGray
    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectHeaderAction(gesterRecognizer: UITapGestureRecognizer) {
        let cell = gesterRecognizer.view as! HeaderView
        delegate?.toggleSection(header: self, section: cell.section!)
    }
}

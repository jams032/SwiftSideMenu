//
//  DrawerTableViewCell.swift
//  SwiftSideMenu
//
//  Copyright © 2019 Jamshed ALam. All rights reserved.
//

import UIKit

class DrawerTableViewCell: UITableViewCell {

    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var SubMenuLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

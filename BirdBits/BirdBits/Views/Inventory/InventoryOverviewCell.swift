//
//  InventoryOverviewCell.swift
//  BirdBits
//
//  Created by Jared Wheeler on 2/25/19.
//  Copyright © 2019 Bird Audio Machines. All rights reserved.
//

import UIKit

class InventoryOverviewCell: UITableViewCell {
    @IBOutlet private var headlineLabel: UILabel!
    
    var headline: String? {
        didSet {
            headlineLabel.text = headline
        }
    }
}

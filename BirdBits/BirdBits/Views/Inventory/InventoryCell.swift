//
//  InventoryCell.swift
//  BirdBits
//
//  Created by Jared Wheeler on 2/26/19.
//  Copyright © 2019 Bird Audio Machines. All rights reserved.
//

import UIKit

class InventoryCell: UITableViewCell {
    
    @IBOutlet private var valueLabel: UILabel!
    @IBOutlet private var unitLabel: UILabel!
    @IBOutlet private var caseCodeLabel: UILabel!
    @IBOutlet private var stockLabel: UILabel!
    @IBOutlet private var manufacturerLabel: UILabel!
    @IBOutlet private var partNumberLabel: UILabel!
    
    var part: PartModel? {
        didSet {
            if let partValues = part?.partValues {
                valueLabel.text = String(describing: partValues.displayValue)
                unitLabel.text = String(describing: partValues.displayUnit)
            }
            caseCodeLabel.text = part?.caseCode
            if let partStock = part?.stock {
                stockLabel.text = String(describing: partStock)
            }
            manufacturerLabel.text = part?.manufacturer
            partNumberLabel.text = part?.partNumber
        }
    }
}


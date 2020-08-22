//
//  HistoryTVCell.swift
//  flytbaseDemo
//
//  Created by vaibhav bhosale on 22/08/20.
//  Copyright © 2020 VB. All rights reserved.
//

import UIKit

class HistoryTVCell: UITableViewCell {

    @IBOutlet weak var lblCalculationOf: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

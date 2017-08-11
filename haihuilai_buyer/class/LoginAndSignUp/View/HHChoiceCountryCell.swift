//
//  HHChoiceCountryCell.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/10.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHChoiceCountryCell: UITableViewCell {
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryNumber: UILabel!
    
    @IBOutlet weak var line: UILabel!
    var choiceModel: HHChoiceModel?{
        didSet{
            countryName.text = choiceModel?.name
            countryNumber.text = choiceModel?.val
        }
    }
}

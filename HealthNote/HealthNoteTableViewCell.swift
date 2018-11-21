//
//  HealthNoteTableViewCell.swift
//  HealthFood
//
//  Created by Apple on 2018/11/7.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class HealthNoteTableViewCell: UITableViewCell {

    @IBOutlet weak var notedetailTextview: UITextView!
    
    
    var item : HealthFoodItem?{
        didSet{
         
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

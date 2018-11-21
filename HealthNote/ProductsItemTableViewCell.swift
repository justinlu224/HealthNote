//
//  HealthNoteItemUITableViewCell.swift
//  HealthFood
//
//  Created by Apple on 2018/11/6.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ProductsItemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCPNameLabel: UILabel!
    
    var healthNote: HealthFoodItem? {
        didSet{
            itemNameLabel.text = healthNote?.name
            itemCPNameLabel.text = healthNote?.applyCompany
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}

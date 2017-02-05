//
//  dayTableViewCell.swift
//  glucagon
//
//  Created by Gautam Ajjarapu on 2/4/17.
//  Copyright © 2017 sahasd. All rights reserved.
//

import UIKit

protocol dayTableViewCellDelegate: class {
    

}


class dayTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var meal: UILabel!
    @IBOutlet weak var calories: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

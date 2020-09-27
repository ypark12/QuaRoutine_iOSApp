//
//  RoutineTableViewCell.swift
//  Productivity
//
//  Created by Diego Griese on 7/10/2020.
//  Copyright © 2020 Diego. All rights reserved.
//

import UIKit

class RoutineTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var streakLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

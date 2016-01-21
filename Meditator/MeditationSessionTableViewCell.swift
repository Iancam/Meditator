//
//  MeditationSessionTableViewCell.swift
//  Meditator
//
//  Created by Ian Campbell on 1/18/16.
//  Copyright © 2016 Ian Campbell. All rights reserved.
//

import UIKit

class MeditationSessionTableViewCell: UITableViewCell {

    // MARK:
    
    @IBOutlet weak var SessionDate: UILabel!
    @IBOutlet weak var SessionDuration: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

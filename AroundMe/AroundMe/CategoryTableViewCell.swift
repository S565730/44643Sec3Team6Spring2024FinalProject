//
//  CategoryTableViewCell.swift
//  AroundMe
//
//  Created by rachana on 4/12/24.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var iconLbl: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  SelectCustomerCell.swift
//  PharmacyManagement
//
//  Created by VU HOANG DUY on 24/5/24.
//

import UIKit

class SelectCustomerCell: UITableViewCell {

    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var customerImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

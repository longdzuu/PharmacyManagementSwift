//
//  BillListCell.swift
//  PharmacyManagement
//
//  Created by VU HOANG DUY on 26/5/24.
//

import UIKit

class BillListCell: UITableViewCell {

    @IBOutlet weak var billEmployeeName: UILabel!
    @IBOutlet weak var billDate: UILabel!
    @IBOutlet weak var billID: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

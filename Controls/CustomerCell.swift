//
//  CustomerCell.swift
//  PharmacyManagement
//
//  Created by VU HOANG DUY on 23/5/24.
//

import UIKit

class CustomerCell: UITableViewCell {

    @IBOutlet weak var customerPhone: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var customerImage: UIImageView!
    var onTap:UITapGestureRecognizer?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

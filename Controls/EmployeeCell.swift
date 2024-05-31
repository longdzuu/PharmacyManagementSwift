//
//  EmployeeCellTableViewCell.swift
//  PharmacyManagement
//
//  Created by VU HOANG DUY on 21/5/24.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    @IBOutlet weak var employeeImageView: UIImageView!
    
    @IBOutlet weak var employeePosition: UILabel!
    @IBOutlet weak var employeeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

//
//  BillCell.swift
//  PharmacyManagement
//
//  Created by VU HOANG DUY on 25/5/24.
//

import UIKit

class BillCell: UITableViewCell {
    
    let drugName = UILabel()
    let quantity = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //tạo label drugName
        drugName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(drugName)
        drugName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        drugName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        drugName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        drugName.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        //tạo UItextfield quantity
        quantity.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(quantity)
        quantity.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        quantity.leadingAnchor.constraint(equalTo: drugName.trailingAnchor, constant: 100).isActive = true
        quantity.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        quantity.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        quantity.textAlignment = .right
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
}

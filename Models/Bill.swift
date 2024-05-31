//
//  Bill.swift
//  PharmacyManagement
//
//  Created by  User on 23.05.2024.
//

import Foundation

class Bill{
    var id:Int
    var customer_id:String
    var employee_id:String
    var date: String
    
    init(id: Int, customer_id: String, employee_id: String,date: String) {
        self.id = id
        self.customer_id = customer_id
        self.employee_id = employee_id
        self.date = date
    }
}

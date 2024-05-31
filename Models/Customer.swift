//
//  Customer.swift
//  PharmacyManagement
//
//  Created by VU HOANG DUY on 23/5/24.
//

import UIKit

class Customer{
    //MARK: Properties
    var id:String
    var name:String
    var gender:String
    var phone:String
    var email:String
    var address:String
    
    init(id: String, name: String, gender: String, phone: String, email: String, address: String) {
        self.id = id
        self.name = name
        self.gender = gender
        self.phone = phone
        self.email = email
        self.address = address
    }
}

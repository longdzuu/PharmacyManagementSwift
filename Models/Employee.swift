//
//  Employee.swift
//  PharmacyManagement
//
//  Created by VU HOANG DUY on 21/5/24.
//

import UIKit

class Employee{
    //MARK: Properties
    var id:String
    var name:String
    var image:UIImage?
    var gender:String
    var phone:String
    var dayOfBirth:String
    var address:String
    var position:String
    var password:String
    
    //MARK: Contructors
    init(id: String, name: String, image: UIImage? = nil, gender: String, phone: String, dayOfBirth: String, address: String, position: String, password: String) {
        self.id = id
        self.name = name
        self.image = image
        self.gender = gender
        self.phone = phone
        self.dayOfBirth = dayOfBirth
        self.address = address
        self.position = position
        self.password = password
    }
}

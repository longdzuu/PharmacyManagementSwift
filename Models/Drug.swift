//
//  Drug.swift
//  PharmacyManagement
//
//  Created by  User on 22.05.2024.
//

import Foundation
import UIKit
class Drug {
    var id: String
    var name: String
    var manufacturer: String
    var image: UIImage?
    var expirationDate: String
    var usage: String
    var quantity: String
    var unit: String
    var price: String
    
    init(id: String, name: String, manufacturer: String, image: UIImage? = nil, expirationDate: String, usage: String, quantity: String, unit: String, price: String) {
        self.id = id
        self.name = name
        self.manufacturer = manufacturer
        self.image = image
        self.expirationDate = expirationDate
        self.usage = usage
        self.quantity = quantity
        self.unit = unit
        self.price = price
    }
    
    static func checkQuantity(drugs:[Drug], drugId:String, sellNumber:Int) -> Bool{
        for drug in drugs {
            if (drug.id == drugId) {
                if let stockQuantity = Int(drug.quantity) {
                    return sellNumber > stockQuantity
                } else {
                    return false
                }
            }
        }
        return false
    }
    
    static func updateQuantity(drugs: inout [Drug], drugId:String, sellNumber:Int) {
        for i in 0..<drugs.count {
            if drugs[i].id == drugId {
                let newQuantity = Int(drugs[i].quantity)! - sellNumber
                drugs[i].quantity = "\(newQuantity)"
                print(drugs[i].quantity)
                break
            }
        }
    }
}




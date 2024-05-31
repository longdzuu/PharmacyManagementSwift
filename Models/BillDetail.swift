//
//  BillDetail.swift
//  PharmacyManagement
//
//  Created by VU HOANG DUY on 23/5/24.
//

import Foundation
class BillDetail{
    var bill_id:Int
    var drugId:Int
    var drugName:String
    var quantity: Int
    var price:Float
    
    init(bill_id: Int, drugId:Int, drugName: String, quantity: Int, price:Float) {
        self.bill_id = bill_id
        self.drugId = drugId
        self.drugName = drugName
        self.quantity = quantity
        self.price = price
    }
    
    static func totalPrice(billDetails:[BillDetail]) -> Float{
        var total = 0
        for billDetail in billDetails {
            total = total + Int(Float(billDetail.quantity) * billDetail.price)
        }
        return Float(total)
    }
    
    static func checkForDuplicates(billDetails: inout [BillDetail], drugDetail: BillDetail) {
        var isFound = false
        for index in 0..<billDetails.count {
            if billDetails[index].drugId == drugDetail.drugId {
                billDetails[index].quantity += drugDetail.quantity
                isFound = true
                break
            }
        }
        
        if !isFound {
            billDetails.append(drugDetail)
        }
    }
    
    static func updateBillDetailBillID(billDetails: inout [BillDetail], newBillID: Int){
        for billDetail in billDetails{
            billDetail.bill_id = newBillID
        }
    }
}

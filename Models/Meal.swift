//
//  Meal.swift
//  FoodManagement2024
//
//  Created by  User on 06.05.2024.
//

import UIKit
class Meal{
    //MARK: Properties
    var name:String
    var image:UIImage?
    var ratingValue:Int
    
    //MARK: Contructors
    init?(name: String, image: UIImage? = nil, ratingValue: Int) {
        if name.isEmpty{
            //Khong tao duoc mon an
            return nil
        }
        if ratingValue < 0 || ratingValue > 5{
            return nil
        }
        self.name = name
        self.image = image
        self.ratingValue = ratingValue
    }
}

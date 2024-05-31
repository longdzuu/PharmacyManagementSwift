//
//  MealCell.swift
//  FoodManagement2024
//
//  Created by  User on 06.05.2024.
//

import UIKit

class MealCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var rating: UIRating!
    @IBOutlet weak var mealName: UILabel!
    //Bat su kien cho cell theo cach 1
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

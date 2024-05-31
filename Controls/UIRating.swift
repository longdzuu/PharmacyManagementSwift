//
//  UIRating.swift
//  FoodManagement2024
//
//  Created by  User on 22.04.2024.
//

import UIKit

class UIRating: UIStackView {
    //MARK: properties
    private var ratingValue = 2
    private var ratingButtons = [UIButton]()
    
    var rating:Int{
        get {
            return ratingValue
        }
        set {
            ratingValue = newValue
            upDateButtonState()
        }
    }
    
    @IBInspectable private var numStarts:Int = 5 {
        didSet {
            ratingSetup()
        }
    }
    
    @IBInspectable private var btnSize:CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            ratingSetup()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ratingSetup()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        ratingSetup()
    }
    
    //MARK: Ham xay dung doi tuong UIRating
    private func ratingSetup(){
        // xoa nhung button da co
        for btn in ratingButtons {
            btn.removeFromSuperview()
            removeArrangedSubview(btn)
        }
        ratingButtons.removeAll()
        
        //Load anh tu file vao bien
        let normal = UIImage(named: "normal")
        let pressed = UIImage(named: "pressed")
        let selected = UIImage(named: "selected")
        
        //Xay dung 5 button
        for _ in 0..<numStarts {
            let btnRating = UIButton()
            btnRating.heightAnchor.constraint(equalToConstant: btnSize.height).isActive = true
            btnRating.widthAnchor.constraint(equalToConstant: btnSize.width).isActive = true
            //btnRating.backgroundColor = UIColor.green
            
            //Dua anh vo button
            btnRating.setImage(normal, for: .normal)
            btnRating.setImage(pressed, for: .highlighted)
            btnRating.setImage(selected, for: .selected)
            
            //Dua button moi vao mang ratinggButtons de quan ly
            ratingButtons.append(btnRating)
            //ratingButtons += [btnRating]
            
            //bat su kien cho tung btnRating
            btnRating.addAction(UIAction(handler: {action in
                if let btn = action.sender as? UIButton{
                    //lay so thu tu cua btn trong mang
                    let index = self.ratingButtons.firstIndex(of: btn)
                    //print(index!)
                    let newValue = index! + 1
                    self.ratingValue = newValue == self.ratingValue ? newValue - 1 : newValue
                    //print(self.ratingValue)
                    
                    //cap nhap lai trang thai button
                    self.upDateButtonState()
                }
            }), for: .touchUpInside)
            
            //Dua cac button moi tao vao trong doi tuong stackview
            addArrangedSubview(btnRating)
        }
        
        //cap nhap trang thai button
        upDateButtonState()
    }
    //MARK: ham cap nhap trang thai cho rating button
    private func upDateButtonState(){
        for (index, btn) in ratingButtons.enumerated(){
            btn.isSelected = index < ratingValue ? true : false
        }
    }
}

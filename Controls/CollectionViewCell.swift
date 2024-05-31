//
//  CollectionViewCell.swift
//  PharmacyManagement
//
//  Created by VU HOANG DUY on 21/5/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
   
    let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
    let label: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 14)
            return label
        }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Thêm ảnh và label vào contentView
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        // ràng buộc cho imageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 60) // Set height of imageView to 60
        ])
                
        // thêm ràng buộc for label
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        //thêm hiệu ứng
        layer.cornerRadius = 15
        layer.masksToBounds = false // Cho đổ bóng
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2 // Độ trong suốt đổ bóng
        layer.shadowOffset = CGSize(width: 1, height: 1) // Độ phân tán của đổ bóng
        layer.shadowRadius = 5 // Độ cong của đổ bóng
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

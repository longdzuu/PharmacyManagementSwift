//
//  PharmacyCell.swift
//  PharmacyManagement
//
//  Created by VU HOANG DUY on 21/5/24.
//

import UIKit

class MedicinCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let pharmacyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let pharmacyNumber: UILabel = {
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
        contentView.addSubview(pharmacyName)
        contentView.addSubview(pharmacyNumber)
        
        // ràng buộc cho imageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            pharmacyName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            pharmacyName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pharmacyName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pharmacyName.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        NSLayoutConstraint.activate([
            pharmacyNumber.topAnchor.constraint(equalTo: pharmacyName.bottomAnchor, constant: 3),
            pharmacyNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pharmacyNumber.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pharmacyNumber.heightAnchor.constraint(equalToConstant: 15)
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

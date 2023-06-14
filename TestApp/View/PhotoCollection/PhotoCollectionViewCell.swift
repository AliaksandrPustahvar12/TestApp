//
//  PhotoCollectionViewCell.swift
//  TestApp
//
//  Created by Aliaksandr Pustahvar on 12.06.23.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    let photoView =  UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        photoView.frame = CGRect(origin: .zero , size: .init(width: contentView.frame.width, height: contentView.frame.height))
        photoView.layer.cornerRadius = 12
        photoView.layer.borderColor = UIColor.systemGray4.cgColor
        photoView.layer.borderWidth = 3
        contentView.addSubview(photoView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        photoView.image = nil
    }
}


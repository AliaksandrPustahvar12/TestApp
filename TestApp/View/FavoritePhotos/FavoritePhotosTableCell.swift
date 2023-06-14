//
//  FavoritePhotosTableCell.swift
//  TestApp
//
//  Created by Aliaksandr Pustahvar on 12.06.23.
//

import UIKit

final class FavoritePhotosTableCell: UITableViewCell {
    let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemGray6.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let customTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.borderColor = UIColor.systemMint.cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 20
        self.backgroundColor = .systemGray5
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.contentView.addSubview(customImageView)
        self.contentView.addSubview(customTextLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            customImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            customImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4),
            customImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4),
            customImageView.widthAnchor.constraint(equalToConstant: 100),
            customImageView.heightAnchor.constraint(equalToConstant: 100),
            
            customTextLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 10),
            customTextLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            customTextLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
}

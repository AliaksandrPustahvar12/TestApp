//
//  PhotoDetailsController.swift
//  Testing
//
//  Created by Aliaksandr Pustahvar on 12.06.23.
//

import UIKit

final class PhotoDetailsController: UIViewController {
    private let netService = NetworkService()
    private let dbService = DataBaseService()
    let imageView = UIImageView()
    let favoriteButton = UIButton(type: .system)
    var detailsItem: DetailsModel!
    var deleteItem: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = .systemMint
        
        Task { @MainActor in
            imageView.image = await netService.getPhoto(from: detailsItem.url)
        }
    }
    
    private func setupView() {

        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor.darkGray
        view.addSubview(imageView)
        
        let preName = UILabel()
        preName.textAlignment = .right
        preName.text = "Name:"
        preName.font = UIFont.systemFont(ofSize: 13, weight: .light)
        preName.textColor = .darkGray
        view.addSubview(preName)
        
        let authorNameLabel = UILabel()
        authorNameLabel.textAlignment = .left
        authorNameLabel.text = detailsItem.name
        authorNameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        authorNameLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(authorNameLabel)
        
        let preLocation = UILabel()
        preLocation.textAlignment = .right
        preLocation.text = "Location:"
        preLocation.font = UIFont.systemFont(ofSize: 13, weight: .light)
        preLocation.textColor = .darkGray
        view.addSubview(preLocation)
        
        let photoLocation = UILabel()
        photoLocation.text = detailsItem.location
        photoLocation.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        photoLocation.textAlignment = .left
        photoLocation.adjustsFontSizeToFitWidth = true
        view.addSubview(photoLocation)
        
        let preDate = UILabel()
        preDate.text = "Created at:"
        preDate.font = UIFont.systemFont(ofSize: 13, weight: .light)
        preDate.textColor = .darkGray
        preDate.textAlignment = .right
        view.addSubview(preDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.dateStyle = .long
        let date: Date? = dateFormatter.date(from: detailsItem.createdAt)
    
        let dateLabel = UILabel()
        dateLabel.textAlignment = .left
        dateLabel.text = dateFormatter.string(from: date ?? .now)
        dateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(dateLabel)
        
        let preDownloads = UILabel()
        preDownloads.text = "Downloads:"
        preDownloads.font = UIFont.systemFont(ofSize: 13, weight: .light)
        preDownloads.textColor = .darkGray
        preDownloads.textAlignment = .right
        view.addSubview(preDownloads)
        
        
        let downloadsLabel = UILabel()
        downloadsLabel.text = detailsItem.downloads
        downloadsLabel.textAlignment = .left
        downloadsLabel.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(downloadsLabel)
        
        favoriteButton.layer.cornerRadius = 18
        favoriteButton.layer.borderWidth = 2
        favoriteButton.tintColor = .black
        favoriteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        favoriteButton.layer.borderColor = UIColor.black.cgColor
        favoriteButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(favoriteButton)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.90),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.width * 0.90)
        ])

        preName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            preName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3),
            preName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 3),
            preName.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            authorNameLabel.leftAnchor.constraint(equalTo: preName.rightAnchor, constant: 3),
            authorNameLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85),
            authorNameLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        preLocation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            preLocation.topAnchor.constraint(equalTo: preName.bottomAnchor, constant: 0),
            preLocation.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 3),
            preLocation.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        photoLocation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoLocation.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 2),
            photoLocation.leftAnchor.constraint(equalTo: preLocation.rightAnchor, constant: 3),
            photoLocation.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85),
            photoLocation.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        preDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            preDate.topAnchor.constraint(equalTo: preLocation.bottomAnchor, constant: 4),
            preDate.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 3),
            preDate.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: preDate.rightAnchor, constant: 3),
            dateLabel.topAnchor.constraint(equalTo: photoLocation.bottomAnchor, constant: 4),
            dateLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        preDownloads.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            preDownloads.topAnchor.constraint(equalTo: preDate.bottomAnchor, constant: 5),
            preDownloads.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 3),
            preDownloads.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        downloadsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downloadsLabel.leftAnchor.constraint(equalTo: preDownloads.rightAnchor, constant: 3),
            downloadsLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            downloadsLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            favoriteButton.widthAnchor.constraint(equalToConstant: 250),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func pushDeleteAlert() {
        let alert = UIAlertController(title: "Delete photo from Favorites?", message: nil, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.dbService.deleteFromFavorites(photoId: self.detailsItem.photoId)
            self.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func buttonAction() {
        if deleteItem {
            pushDeleteAlert()
        } else {
            dbService.addToFavorites(photo: detailsItem)
            navigationController?.popToRootViewController(animated: true)
        }
    }
}

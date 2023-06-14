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
        setupScrollView()
        view.backgroundColor = .systemMint
        
        Task { @MainActor in
            imageView.image = await netService.getPhoto(from: detailsItem.url)
        }
    }
    
    private func setupScrollView() {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.isScrollEnabled = true
        view.addSubview(scrollView)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor.darkGray
        scrollView.addSubview(imageView)
        
        let preName = UILabel()
        preName.textAlignment = .right
        preName.text = "Name:"
        preName.font = UIFont.systemFont(ofSize: 13, weight: .light)
        preName.textColor = .darkGray
        scrollView.addSubview(preName)
        
        let authorNameLabel = UILabel()
        authorNameLabel.textAlignment = .left
        authorNameLabel.text = detailsItem.name
        authorNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        authorNameLabel.adjustsFontSizeToFitWidth = true
        scrollView.addSubview(authorNameLabel)
        
        let preLocation = UILabel()
        preLocation.textAlignment = .right
        preLocation.text = "Location:"
        preLocation.font = UIFont.systemFont(ofSize: 13, weight: .light)
        preLocation.textColor = .darkGray
        scrollView.addSubview(preLocation)
        
        let photoLocation = UILabel()
        photoLocation.text = detailsItem.location
        photoLocation.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        photoLocation.textAlignment = .left
        photoLocation.adjustsFontSizeToFitWidth = true
        scrollView.addSubview(photoLocation)
        
        let preDate = UILabel()
        preDate.text = "Created at:"
        preDate.font = UIFont.systemFont(ofSize: 13, weight: .light)
        preDate.textColor = .darkGray
        preDate.textAlignment = .right
        scrollView.addSubview(preDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.dateStyle = .long
        let date: Date? = dateFormatter.date(from: detailsItem.createdAt)
    
        let dateLabel = UILabel()
        dateLabel.textAlignment = .left
        dateLabel.text = dateFormatter.string(from: date ?? .now)
        dateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        scrollView.addSubview(dateLabel)
        
        let preDownloads = UILabel()
        preDownloads.text = "Downloads:"
        preDownloads.font = UIFont.systemFont(ofSize: 13, weight: .light)
        preDownloads.textColor = .darkGray
        preDownloads.textAlignment = .right
        scrollView.addSubview(preDownloads)
        
        
        let downloadsLabel = UILabel()
        downloadsLabel.text = detailsItem.downloads
        downloadsLabel.textAlignment = .left
        downloadsLabel.font = UIFont.boldSystemFont(ofSize: 16)
        scrollView.addSubview(downloadsLabel)
        
        favoriteButton.layer.cornerRadius = 18
        favoriteButton.layer.borderWidth = 2
        favoriteButton.tintColor = .black
        favoriteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        favoriteButton.layer.borderColor = UIColor.black.cgColor
        favoriteButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        scrollView.addSubview(favoriteButton)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.75),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.width * 0.75)
        ])
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        preName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            preName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            preName.rightAnchor.constraint(equalTo: authorNameLabel.leftAnchor, constant: -3),
            preName.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorNameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            authorNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 7),
            authorNameLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        preLocation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            preLocation.topAnchor.constraint(equalTo: preName.bottomAnchor, constant: 1),
            preLocation.rightAnchor.constraint(equalTo: photoLocation.leftAnchor, constant: -3),
            preLocation.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        photoLocation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoLocation.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            photoLocation.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 4),
            photoLocation.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        preDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            preDate.topAnchor.constraint(equalTo: preLocation.bottomAnchor, constant: 5),
            preDate.rightAnchor.constraint(equalTo: dateLabel.leftAnchor, constant: -3),
            preDate.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: photoLocation.bottomAnchor, constant: 6),
            dateLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        preDownloads.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            preDownloads.topAnchor.constraint(equalTo: preDate.bottomAnchor, constant: 5),
            preDownloads.rightAnchor.constraint(equalTo: downloadsLabel.leftAnchor, constant: -3),
            preDownloads.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        downloadsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downloadsLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            downloadsLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            downloadsLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            favoriteButton.topAnchor.constraint(equalTo: downloadsLabel.bottomAnchor, constant: 20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 250),
            favoriteButton.heightAnchor.constraint(equalToConstant: 45)
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

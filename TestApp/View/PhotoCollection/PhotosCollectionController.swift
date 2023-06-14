//
//  PhotosCollectionController.swift
//  TestApp
//
//  Created by Aliaksandr Pustahvar on 11.06.23.
//

import UIKit

final class PhotosCollectionController: UICollectionViewController {
    
    private let netService = NetworkService()
    private let dbService = DataBaseService()
    private var array: [PhotoDto]?
    private var searchingText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let itemSize: CGFloat = (view.frame.size.width / 3) - 14
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = 8
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        
        setUpView()
        
        Task { @MainActor in
            array = await netService.fetchData()
            collectionView.reloadData()
        }
    }
    
    private func setUpView() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search photos"
        searchController.searchBar.tintColor = .black
        searchController.searchBar.autocapitalizationType = .none
        searchController.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.backgroundColor = .systemMint
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor , constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
    }
}

extension PhotosCollectionController: UISearchControllerDelegate {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        array?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! PhotoCollectionViewCell
        
        if let url = array?[indexPath.row].urls.thumb {
            Task { @MainActor in
                cell.photoView.image = await netService.getPhoto(from: url)
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let vc = PhotoDetailsController()
        vc.favoriteButton.setTitle("Add to favorites", for: .normal)
        vc.deleteItem = false
        
        if  let item = array?[indexPath.row] {
            vc.detailsItem = item.asDetailsModel
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PhotosCollectionController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchingText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Task { @MainActor in
            array = await netService.searchPhotos(search: searchingText)
            collectionView.reloadData()
        }
    }
}

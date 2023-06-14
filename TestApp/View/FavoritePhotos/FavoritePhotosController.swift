//
//  FavoritePhotosController.swift
//  TestApp
//
//  Created by Aliaksandr Pustahvar on 12.06.23.
//

import UIKit

final class FavoritePhotosController: UIViewController {
    
    private let netService = NetworkService()
    private let dbService = DataBaseService()
    private var favoritesArray: [Photo] = []
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(FavoritePhotosTableCell.self, forCellReuseIdentifier:  "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemMint
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesArray = dbService.favorites()
        tableView.reloadData()
    }
}

extension FavoritePhotosController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoritePhotosTableCell
        cell.customTextLabel.text = favoritesArray[indexPath.row].name
        
        if let url = favoritesArray[indexPath.row].url {
            Task { @MainActor in
                cell.customImageView.image = await netService.getPhoto(from: url)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = favoritesArray[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {_,_, completionHandler in
            self.dbService.deleteFromFavorites(photoId: item.photoId ?? "")
            self.favoritesArray.remove(at: indexPath.row)
            self.tableView.reloadData()
            completionHandler(true)
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        return swipeConfiguration
    }
}

extension FavoritePhotosController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let photo = favoritesArray[indexPath.row]
        let vc = PhotoDetailsController()
        vc.detailsItem = photo.asDetailsModel
        vc.deleteItem = true
        vc.favoriteButton.setTitle("Delete from favorites", for: .normal)
        navigationController?.pushViewController(vc, animated: true)
    }
}


//
//  TabBarController.swift
//  TestApp
//
//  Created by Aliaksandr Pustahvar on 11.06.23.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = .systemMint
        self.tabBar.tintColor = .black
        view.backgroundColor = .systemMint
        
        let photoVC = PhotosCollectionController(collectionViewLayout: UICollectionViewFlowLayout())
        
        viewControllers = [
            createVC(rootViewController: photoVC, title: "Photos", image: UIImage(systemName: "photo")),
            createVC(rootViewController: FavoritePhotosController(), title: "Favorites", image: UIImage(systemName: "heart.fill"))
        ]
    }
    
    func createVC(rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        navigationVC.navigationBar.tintColor = .black
        navigationVC.hidesBottomBarWhenPushed = false
        return navigationVC
    }
}


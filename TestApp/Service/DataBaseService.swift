//
//  DataBaseService.swift
//  TestApp
//
//  Created by Aliaksandr Pustahvar on 13.06.23.
//

import UIKit
import CoreData

final class DataBaseService {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func favorites() -> [Photo] {
        let request: NSFetchRequest<Photo> = Photo.fetchRequest()
        var fetchetPhotos: [Photo] = []
        
        do {
            fetchetPhotos = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        return fetchetPhotos
    }
    
    func addToFavorites(photo: DetailsModel ) {
        let photos = favorites()
        if photos.map({ $0.photoId}).contains(photo.photoId) {
            return
        }
        let newPhoto = Photo(context: context)
        newPhoto.name = photo.name
        newPhoto.url = photo.url
        newPhoto.photoId = photo.photoId
        newPhoto.downloads = photo.downloads
        newPhoto.createdAt = photo.createdAt
        newPhoto.location = photo.location
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteFromFavorites(photoId: String) {
        do {
            let request = Photo.fetchRequest()
            request.predicate = NSPredicate(format: "photoId = %@", photoId)
            guard let photo = try context.fetch(request).first else { return }
            context.delete(photo)
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

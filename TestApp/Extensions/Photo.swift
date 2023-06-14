//
//  Photo.swift
//  TestApp
//
//  Created by Aliaksandr Pustahvar on 14.06.23.
//

import Foundation


extension Photo {
    var asDetailsModel: DetailsModel {
        let detailsModel = DetailsModel(
            name: self.name ?? "",
            url: self.url ?? "",
            location: self.location ?? "",
            createdAt: self.createdAt ?? "",
            photoId: self.photoId ?? "",
            downloads: self.downloads ?? "")
        return detailsModel
    }
}

//
//  PhotoDto.swift
//  TestApp
//
//  Created by Aliaksandr Pustahvar on 14.06.23.
//

import Foundation

extension PhotoDto {
    var asDetailsModel: DetailsModel {
        let detailsModel = DetailsModel(
            name: self.user?.name ?? "",
            url: self.urls.small,
            location: self.user?.location ?? "",
            createdAt: self.createdAt,
            photoId: self.id,
            downloads: self.downloads?.asSrtring ?? "")
        return detailsModel
    }
}

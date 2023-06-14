//
//  DetailsModel.swift
//  TestApp
//
//  Created by Aliaksandr Pustahvar on 14.06.23.
//

import Foundation

struct DetailsModel {
    let name: String
    let url: String
    let location: String
    let createdAt: String
    let photoId: String
    let downloads: String
    
    func createDetailsModel(photoDto: PhotoDto) -> DetailsModel {
        DetailsModel(
            name: photoDto.user?.name ?? "",
            url: photoDto.urls.small,
            location: photoDto.user?.location ?? "",
            createdAt: photoDto.createdAt,
            photoId: photoDto.id,
            downloads: photoDto.downloads?.asSrtring ?? "")
    }
}

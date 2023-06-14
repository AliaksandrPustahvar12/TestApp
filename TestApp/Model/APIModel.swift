//
//  APIModel.swift
//  TestApp
//
//  Created by Aliaksandr Pustahvar on 11.06.23.
//

import Foundation


struct PhotoDto: Identifiable, Decodable {
    let id: String
    let urls: UrlDto
    let downloads: Int?
    let user: UserDto?
    let createdAt: String
    
    struct UserDto: Identifiable, Decodable {
        let id: String?
        let name: String?
        let location: String?
    }
    
    struct UrlDto: Decodable {
        let thumb: String
        let small: String
    }
}

struct SearchResultDto: Decodable {
    let results: [PhotoDto]
}


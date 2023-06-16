//
//  NetworkService.swift
//  TestApp
//
//  Created by Aliaksandr Pustahvar on 11.06.23.
//

import Alamofire
import Foundation
import UIKit

final class NetworkService {
    
    private let key = "ZrHfy08DuQ-ro4k867m9xPbX7HdSUcJrW8QzrZaHl-I"
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func fetchData() async -> [PhotoDto]? {
        var urlComponents = getUrlComponents()
        urlComponents.path = "/photos/random/"
        urlComponents.queryItems?.append(.init(name: "count", value: String((25...35).randomElement() ?? 28)))
        do {
            return try await AF.request(urlComponents).serializingDecodable([PhotoDto].self,
                                                                            decoder: decoder).value
        } catch {
            print(error)
            return nil
        }
    }
    
    func searchPhotos(search: String) async  -> [PhotoDto]? {
        var urlComponents = getUrlComponents()
        urlComponents.path = "/search/photos"
        urlComponents.queryItems?.append(.init(name: "per_page", value: "27"))
        urlComponents.queryItems?.append(.init(name: "query", value: search))
        do {
            let dto =  try await  AF.request(urlComponents).serializingDecodable(SearchResultDto.self, decoder: decoder).value
            return dto.results
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getPhoto (from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        do {
            let data = try await
            AF.request(url).serializingData().value
            return UIImage(data: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func getUrlComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        urlComponents.queryItems = [.init(name: "client_id", value: key)]
        return urlComponents
    }
}

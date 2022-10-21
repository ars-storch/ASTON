//
//  DownloadService.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 14.10.2022.
//

import Foundation

struct AllCharactersRequest: DataRequest {
    
    var url: String = {
            let baseURL: String = "https://rickandmortyapi.com"
            let path: String = "/api/character"
            return baseURL + path
    }()
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> [Character] {
        let decoder = JSONDecoder()
        let response = try decoder.decode(CharactersResponse.self, from: data)
        return response.results
    }

}

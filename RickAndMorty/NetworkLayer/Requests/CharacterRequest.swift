//
//  CharacterRequest.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 15.10.2022.
//

import Foundation

struct CharacterRequest: DataRequest {
    
    var url: String
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> Character {
        let decoder = JSONDecoder()
        let response = try decoder.decode(Character.self, from: data)
        return response
    }

}

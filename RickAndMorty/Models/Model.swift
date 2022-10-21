//
//  Characters.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 14.10.2022.
//

import Foundation

struct CharactersResponse: Codable {
    let results: [Character]
}

struct EpisodesResponse: Codable {
    var results: [Episode]
}

struct Character: Codable {
    var name: String
    var status: String
    var gender: String
    var image: String
    var episodes: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case status
        case gender
        case image
        case episodes = "episode"
    }
}

struct Episode: Codable {
    var name: String
    var characters: [String] 
}

enum UserDefaultKeys: String {
    case isLoggedIn = "IsLoggedIn"
}

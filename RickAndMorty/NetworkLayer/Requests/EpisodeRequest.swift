//
//  EpisodeRequest.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 15.10.2022.
//

import Foundation

struct EpisodeRequest: DataRequest {
    
    var url: String = {
            let baseURL: String = "https://rickandmortyapi.com"
            let path: String = "/api/episode"
            return baseURL + path
    }()
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> Episode {
        let decoder = JSONDecoder()
        let response = try decoder.decode(Episode.self, from: data)
        return response
    }

}

protocol CharactersFromEpisodeClientService {
    func downloadCharacter<Request: DataRequest>(request: Request, completion: @escaping (Character?, Error?) -> Void)
    func setCharacters(from url: String, completion: @escaping ((Character) -> Void))
}

final class CharactersFromEpisodeClient {
    static let shared = CharactersFromEpisodeClient(responseQueue: .main, session: URLSession.shared)
    
    let responseQueue: DispatchQueue?
    let session: URLSession
    
    init(responseQueue: DispatchQueue?, session: URLSession) {
        self.responseQueue = responseQueue
        self.session = session
    }
    
    private func dispatchCharacter(characters: Character? = nil, error: Error? = nil, completion: @escaping (Character?, Error?) -> Void) {
        guard let responseQueue = responseQueue else {
            completion(characters, error)
            return
        }
        responseQueue.async {
            completion(characters, error)
        }
    }
    
}

extension CharactersFromEpisodeClient: CharactersFromEpisodeClientService {
    
    func downloadCharacter<Request>(request: Request, completion: @escaping (Character?, Error?) -> Void) where Request : DataRequest {
        let service: NetworkService = DefaultNetworkService()
        
        service.request(request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                guard let character: Character = response as? Character else { return }
                self.dispatchCharacter(characters: character, completion: completion)
            case .failure(let error):
                self.dispatchCharacter(error: error, completion: completion)
            }
            
        }
    }
    
    func setCharacters(from url: String, completion: @escaping ((Character) -> Void)) {

        let request = CharacterRequest(url: url)
        downloadCharacter(request: request) { character, error in
            guard let character = character else {
                print(error?.localizedDescription ?? "Error occured while getting character.")
                return
            }
            completion(character) 
        }
        
    }
    
}

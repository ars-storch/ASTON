//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 14.10.2022.
//

import Foundation

protocol CharacterListViewModel: AnyObject {
    var characters: [Character] { get set }
    var onFetchCharactersSucceed: (() -> Void)? { get set }
    var onFetchCharactersFailure: ((Error) -> Void)? { get set }
    func fetchCharacters()
}

final class CharacterListDefaultViewModel: CharacterListViewModel {
    
    private let networkService: DefaultNetworkService
    
    init(networkService: DefaultNetworkService) {
        self.networkService = networkService
    }
    
    var characters: [Character] = []
    var onFetchCharactersSucceed: (() -> Void)?
    var onFetchCharactersFailure: ((Error) -> Void)?
    
    func fetchCharacters() {
        let request = AllCharactersRequest() 
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                print(characters.count)
                self?.onFetchCharactersSucceed?()
            case .failure(let error):
                self?.onFetchCharactersFailure?(error)
            }
        }
    }
    
}

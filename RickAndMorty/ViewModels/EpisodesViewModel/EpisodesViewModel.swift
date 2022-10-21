//
//  EpisodesViewModel.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 14.10.2022.
//

import Foundation

protocol EpisodeListViewModel: AnyObject {
    var episodesWithOurCharacter: [Episode] { get set }
    var charsFromAllEpisodes: CharactersFromAllEpisodes { get set }
    var episodesURLS: [String] { get set }
    var onFetchSucceed: (() -> Void)? { get set }
    var onFetchFailure: ((Error) -> Void)? { get set }
    func fetchEpisodes()
}

final class EpisodeListDefaultViewModel: EpisodeListViewModel {
    var onFetchSucceed: (() -> Void)?
    var onFetchFailure: ((Error) -> Void)?
    
    private let networkService: DefaultNetworkService
    var charsFromAllEpisodes = CharactersFromAllEpisodes()
    var episodesWithOurCharacter: [Episode] = []
    var episodesURLS: [String] = []
    
    init(networkService: DefaultNetworkService) {
        self.networkService = networkService
    }
    
    func fetchEpisodes() {
        for url in episodesURLS {
            let request = EpisodeRequest(url: url)
            networkService.request(request) { [weak self] result in
                switch result {
                case .success(let episode):
                    self?.episodesWithOurCharacter.append(episode)
                    self?.onFetchSucceed?()
                case .failure(let error):
                    self?.onFetchFailure?(error)
                }
            }
        }
        print("Episodes with our character: \(episodesWithOurCharacter.count)")
    }
}
 
struct CharactersFromAllEpisodes {
    var charactersFromAllEpisodes: [[Character]] = []
    var charactersFromOneEpisode: [Character] = []
}

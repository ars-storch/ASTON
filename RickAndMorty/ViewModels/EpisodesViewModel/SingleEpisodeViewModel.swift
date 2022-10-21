//
//  SingleEpisodeViewModel.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 15.10.2022.
//

import UIKit

protocol SingleEpisodeViewModel {
    var episode: Episode { get set }
}

final class SingleEpisodeDefaultViewModel: SingleEpisodeViewModel {
    
    var episode: Episode
    
    init(episode: Episode) {
        self.episode = episode
    }
}

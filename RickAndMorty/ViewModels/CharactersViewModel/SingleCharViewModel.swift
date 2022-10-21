//
//  SingleCharViewModel.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 15.10.2022.
//

import UIKit

protocol SingleCharViewModel {
    var char: Character { get set }
}

final class SingleCharDefaultViewModel: SingleCharViewModel {
    
    var char: Character
    
    init(char: Character) {
        self.char = char
    }
}

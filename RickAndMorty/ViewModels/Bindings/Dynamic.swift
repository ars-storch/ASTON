//
//  Dynamic.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 14.10.2022.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
}

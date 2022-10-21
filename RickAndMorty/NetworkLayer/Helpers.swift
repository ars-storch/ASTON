//
//  Helpers.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 15.10.2022.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol DataRequest {
    associatedtype Response
    
    var url: String { get set }
    var method: HTTPMethod { get }
    
    func decode(_ data: Data) throws -> Response
}

extension DataRequest where Response: Codable {
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

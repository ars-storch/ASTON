//
//  Networker.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 14.10.2022.
//

import Foundation

protocol NetworkService {
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void)
}

enum ErrorResponse: String {
    case invalidEndpoint = "Invalid endpoint"
    case invalidResponse = "Invalid response"
}

final class DefaultNetworkService: NetworkService {
    
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) {
      
        guard let urlComponent = URLComponents(string: request.url) else {
            let error = NSError(domain: ErrorResponse.invalidEndpoint.rawValue, code: 404, userInfo: nil)
            print("Failed to construct url component.")
            return completion(.failure(error))
        }
        
        guard let url = urlComponent.url else {
            let error = NSError(domain: ErrorResponse.invalidEndpoint.rawValue, code: 404, userInfo: nil)
            print("Failed to construct url.")
            return completion(.failure(error))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard response is HTTPURLResponse else {
                return completion(.failure(NSError()))
            }
            
            guard let data = data else {
                return completion(.failure(NSError()))
            }
            
            do {
                try completion(.success(request.decode(data)))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
        .resume()
    }
}

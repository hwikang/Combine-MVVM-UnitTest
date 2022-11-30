//
//  Network.swift
//  BookSearch
//
//  Created by 강휘 on 2022/11/30.
//

import Foundation
import Combine

class NetworkManager {
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetchData<T: Decodable> (url: String, dataType: T.Type) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.urlError
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode  else {
            throw NetworkError.invalid
        }
        return try JSONDecoder().decode(T.self, from: data)

    }
    
    func fetchData<T: Decodable> (url: String, dataType: T.Type) throws -> AnyPublisher<T, Error> {
        guard let url = URL(string: url) else {
            throw NetworkError.urlError
        }
    
        return session.dataTaskPublisher(for: url)
            .tryMap({ data,response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.invalid
                }
                return data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
           

    }
}
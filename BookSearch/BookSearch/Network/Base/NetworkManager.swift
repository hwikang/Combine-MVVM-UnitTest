//
//  Network.swift
//  BookSearch
//
//  Created by 강휘 on 2022/11/30.
//

import Foundation
import Combine

final class NetworkManager {
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetchData<T:Decodable> (url: String, dataType: T.Type, completion: @escaping ((Result<T,Error>) -> Void)){
        print("url \(url)")

         guard let url = URL(string: url) else {
             completion(.failure(NetworkError.urlError))
             return 
         }
         session.dataTask(with: url) { (data, response, error) in
             if let error = error {
                 print(error)
                 completion(.failure(error))
                 return
             }
             if let data = data,
                let response = response as? HTTPURLResponse,
                200..<300 ~= response.statusCode {
                 do {
                     let data = try JSONDecoder().decode(T.self, from: data)
                     completion(.success(data))
                 } catch {
                     print(error)
                     completion(.failure(NetworkError.failToDecode))
                 }
             }else {
                 completion(.failure(NetworkError.invalid))
             }
         }.resume()
         
     }
}
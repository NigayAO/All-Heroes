//
//  NetworkManager.swift
//  WikiHeroes
//
//  Created by Alik Nigay on 12.04.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case descriptionError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(completion: @escaping(Result<[Hero], NetworkError>) -> Void) {
        guard let url = URL(string: Link.allHeroes.rawValue) else {
            completion(.failure(.noData))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let receivedData = try JSONDecoder().decode([Hero].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(receivedData))
                }
            } catch {
                completion(.failure(.descriptionError))
            }

        }.resume()
    }
    
    func fetchImage(urlString: String) -> Data? {
        guard let url = URL(string: urlString) else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return imageData
    }
}

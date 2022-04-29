//
//  AFApiService.swift
//  News
//
//  Created by Omar Khalid on 28/04/2022.
//

import Foundation
import Alamofire

protocol MovieApiService {
    func getMovieData(completion: @escaping (Result<MoviesData, Error>) -> Void)
}


class AFApiService: MovieApiService {
    func getMovieData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        let apiEndpoint = "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
        
        AF.request(apiEndpoint).validate().response { [weak self] response in
            switch response.result {
            case .success(let data):
                do {
                    guard let data = data else { return }
                    if let list = try self?.parseMovieData(data) {
                        DispatchQueue.main.async {
                            completion(.success(list))
                        }
                    }
                } catch let err {
                    print("Something went wrong while decoding the response...")
                    DispatchQueue.main.async {
                        completion(.failure(err))
                    }
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func parseMovieData(_ data: Data) throws -> MoviesData {
        let decoder = JSONDecoder()
        let list = try decoder.decode(MoviesData.self, from: data)
        return list
    }
    
}

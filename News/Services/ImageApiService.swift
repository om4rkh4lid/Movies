//
//  ImageApiService.swift
//  News
//
//  Created by Omar Khalid on 29/04/2022.
//

import Foundation
import Alamofire


struct Success {}

protocol DetailApiService {
    func getMovieImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void)
    func markMovieAsFavorite(withId movieId: Int, completion: @escaping (Result<Success, Error>) -> Void)
}

class AFDetailApiService: DetailApiService {
    func markMovieAsFavorite(withId movieId: Int, completion: @escaping (Result<Success, Error>) -> Void) {
        let endpoint = "https://api.themoviedb.org/3/account/12316617/favorite?api_key=840902587d57fefa51a1160a33af106d&session_id=852107e48ac940a093b452c8247610e5dc1cbb80"
        let headers: HTTPHeaders = [.accept("application/json"), .acceptCharset("utf8")]
        let body: [String: Any] = ["media_type": "movie", "media_id": movieId, "favorite": true]
        
        AF.request(endpoint, method: .post, parameters: body, encoding: JSONEncoding(), headers: headers).validate().response{ res in
            switch res.result {
            case .success(let _):
                DispatchQueue.main.async {
                    completion(.success(Success()))
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getMovieImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let endpoint = "https://image.tmdb.org/t/p/w300" + urlString
        AF.request(endpoint).validate().response { res in
            switch res.result {
            case .success(let data):
                guard let data = data else { return }
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(.success(image))
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
    
    
}

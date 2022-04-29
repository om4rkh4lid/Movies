//
//  Model.swift
//  News
//
//  Created by Omar Khalid on 22/04/2022.
//

import Foundation

struct MoviesData: Decodable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    let id: Int
    let title: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let overview: String?
    
    private enum CodingKeys: String, CodingKey {
        case title, overview, id
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
    }
    
}

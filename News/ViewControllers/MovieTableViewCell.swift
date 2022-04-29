//
//  MovieTableViewCell.swift
//  News
//
//  Created by Omar Khalid on 22/04/2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieOverview: UILabel!
    
   
    @IBOutlet weak var movieRate: UILabel!
    
    @IBOutlet weak var movieYear: UILabel!
    
    // Setup movies values
    func setCellWithValuesOf(_ movie:Movie) {
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, overview: movie.overview, poster: movie.posterImage)
    }
    
    // Update the UI views
    private func updateUI(title: String?, releaseDate: String?, rating: Double?, overview: String?, poster: String?) {
        
        self.movieTitle.text = title
        self.movieYear.text = releaseDate
        guard let rate = rating else {return}
        self.movieRate.text = String(rate)
        self.movieOverview.text = overview
        
        guard let posterString = poster else {return}
        let urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            self.moviePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we clear out the old one
        self.moviePoster.image = nil
        
        getImageDataFrom(url: posterImageURL)
        
    }
    
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.moviePoster.image = image
                }
            }
        }.resume()
    }
    
    
    
}

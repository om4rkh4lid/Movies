//
//  DetailPresenter.swift
//  News
//
//  Created by Omar Khalid on 29/04/2022.
//

import Foundation

protocol DetailPresenter {
    init(view: DetailView, apiService: DetailApiService)
    func onViewDidLoad(imageUrl: String)
    func onFavoriteClicked(movie: Movie)
}

class MovieDetailPresenter: DetailPresenter {
    
    weak var view: DetailView?
    
    var api: DetailApiService
    
    required init(view: DetailView, apiService: DetailApiService) {
        self.view = view
        self.api = apiService
    }
    
    func onViewDidLoad(imageUrl: String) {
        api.getMovieImage(from: imageUrl) { [weak self] result in
            switch result {
            case .success(let image):
                self?.view?.onImageFetched(image: image)
            case .failure(_): break
                
            }
        }
        
    }
    
    func onFavoriteClicked(movie: Movie) {
        api.markMovieAsFavorite(withId: movie.id) { [weak self] result in
            switch result {
            case .success(_):
                self?.view?.onMovieMarkedAsFavorite()
            case .failure(_): break
                
            }
        }
        
    }

    
    
}

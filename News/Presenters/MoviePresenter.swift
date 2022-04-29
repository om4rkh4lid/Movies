//
//  MoviePresenter.swift
//  News
//
//  Created by Omar Khalid on 28/04/2022.
//

import Foundation

// what events should the presenter expect from the View?
protocol DataPresenter {
    init(view: DataView, apiService: MovieApiService)
    func onViewDidLoad()
}

class MoviePresenter: DataPresenter {
    
    
    // we declare view as a weak property to avoid retain cycles — View should own Presenter, and Presenter should be able to talk to View through its weak (not strong!) property.
    weak var view: DataView?
    
    var api: MovieApiService
    
    required init(view: DataView, apiService: MovieApiService) {
        self.view = view
        self.api = apiService
    }
    
    func onViewDidLoad() {
        api.getMovieData { [weak self] result in
            switch result {
            case .success(let data):
                self?.view?.onDataFetched(items: data.movies)
            case .failure(let error):
                self?.view?.onDataFetchFailed(errorMessage: error.localizedDescription)
            }
        }
        
    }
    
    
    
    
}

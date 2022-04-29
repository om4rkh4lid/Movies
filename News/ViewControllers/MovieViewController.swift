//
//  ViewController.swift
//  News
//
//  Created by Omar Khalid on 22/04/2022.
//

import UIKit

// what are the events that a view should react to?
protocol DataView: AnyObject {
    func onDataFetched(items: [Movie])
    func onDataFetchFailed(errorMessage: String)
}


class MovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = []
    
    // implicitly unwrapped because we can't pass it in the initializer (since the presenter needs a reference to this view to be created), yet we need it to be non-optional because without it the view is useless!
    var presenter: DataPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        presenter.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: index, animated: true)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailViewController
        
        destination.presenter = MovieDetailPresenter(view: destination, apiService: AFDetailApiService())
        
        let index = tableView.indexPathForSelectedRow!
        let selectedMovie = movies[index.row]
        destination.moviePosterImage = (tableView(tableView, cellForRowAt: index) as! MovieTableViewCell).moviePoster.image
        destination.movie = selectedMovie
        
    }
    
}


// MARK: DataView
extension MovieViewController: DataView {
    
    func onDataFetched(items: [Movie]) {
        movies = items
        tableView.reloadData()
    }
    
    func onDataFetchFailed(errorMessage: String) {
        let dialogMessage = UIAlertController(title: "Error Fetching Data!", message: errorMessage, preferredStyle: .alert)
         let ok = UIAlertAction(title: "OK", style: .default, handler: { _ in
             
          })
         dialogMessage.addAction(ok)
         self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
}



// MARK: UITableViewDataSource
extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        
        cell.setCellWithValuesOf(movies[indexPath.row])
        
        return cell
    }
    
    
}




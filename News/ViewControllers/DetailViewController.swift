//
//  DetailViewController.swift
//  News
//
//  Created by Omar Khalid on 28/04/2022.
//

import UIKit

protocol DetailView: AnyObject {
    func onImageFetched(image: UIImage)
    func onMovieMarkedAsFavorite()
}


class DetailViewController: UIViewController, DetailView {
    
    var presenter: DetailPresenter!
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    
    var movie: Movie?
    var moviePosterImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = movie?.title
        releaseDate.text = movie?.year
        summaryTextView.text = movie?.overview
        presenter.onViewDidLoad(imageUrl: movie?.posterImage ?? "")
        
    }
    
    func onImageFetched(image: UIImage) {
        imageView.image = image
    }
    
    func onMovieMarkedAsFavorite() {
        let alert = UIAlertController(title: "Success", message: "Movie successfully added to your favorites.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    @IBAction func onFavoriteTapped(_ sender: Any) {
        presenter.onFavoriteClicked(movie: movie!)
    }
    
}

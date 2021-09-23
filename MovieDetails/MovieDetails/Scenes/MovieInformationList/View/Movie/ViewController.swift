import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var likeMovieButton: UIButton!
    
    @IBInspectable var movieLiked: Bool = false { didSet { self.changeLikeSymbol() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }

    func setupScreen() {
        let service = MovieService()
        
        let movieID = 181812
        service.fetchMovieDetails(movieID: movieID, posterWidth: 500) { movieData, posterData in
            self.updateMovieDetails(movie: movieData, poster: posterData)
        }
    }
    
    func updateMovieDetails(movie: Movie, poster: Data) {
        movieTitleLabel.text = movie.original_title
        likesLabel.textWithSF(text: "\(movie.vote_count) Likes", symbol: "heart.fill")
        popularityLabel.textWithSF(text: "\(movie.popularity)", symbol: "person.crop.circle.fill.badge.checkmark")
        durationLabel.textWithSF(text: "\(movie.runtime) min", symbol: "clock.fill")
        likeMovieButton.setButtonSF(symbol: "heart")
        movieImage.image = UIImage(data: poster)
    }
    
    func changeLikeSymbol() {
        movieLiked ? likeMovieButton.setButtonSF(symbol: "heart.fill") : likeMovieButton.setButtonSF(symbol: "heart")
    }
    
    @IBAction func likeMovie(_ sender: Any) {
        movieLiked.toggle()
    }
}


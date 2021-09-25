import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var likeMovieButton: UIButton!
    
    @IBOutlet weak var relatedMoviesTableView: UITableView!
    
    @IBInspectable var movieLiked: Bool = false { didSet { self.changeLikeSymbol() } }
    
    let movieID = 181812
    let key = "76a63be0aae78226a632aacfd082fd6e"
    
    let adapter = RelatedMovieAdapter()
    let movieService = MovieService()
    let relatedMoviesService = RelatedMoviesService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAdapter()
        setupScreen()
    }
    
    func setupAdapter() {
        relatedMoviesTableView.dataSource = adapter
    }

    func setupScreen() {
        self.movieService.fetchMovieDetails(movieID: self.movieID, key: self.key) { movieData in
            self.updateMovieDetails(movie: movieData)
        }
        self.relatedMoviesService.fetchRelatedMovies(movieID: self.movieID, key: self.key) { relatedMovies in
            self.updateRelatedMoviesTable(movies: relatedMovies)
        }
    }
    
    func updateMovieDetails(movie: Movie) {
        movieTitleLabel.text = movie.original_title
        likesLabel.textWithSF(text: "\(movie.vote_count) Likes", symbol: "heart.fill")
        popularityLabel.textWithSF(text: "\(movie.popularity)", symbol: "person.crop.circle.fill.badge.checkmark")
        durationLabel.textWithSF(text: "\(movie.runtime) min", symbol: "clock.fill")
        likeMovieButton.setButtonSF(symbol: "heart")
        let posterService = PosterService()
        posterService.fetchMoviePoster(posterPath: movie.poster_path, width: "original") { data in
            self.movieImage.image = UIImage(data: data)
        }
    }
    
    func updateRelatedMoviesTable(movies: [RelatedMovie]) {
        let genreService = GenreService()
        genreService.fetchMovieGenres(key: key) { genres in
            self.adapter.relatedMovies = movies
            self.adapter.genres = genres
            self.relatedMoviesTableView.reloadData()
        }
    }
    
    func changeLikeSymbol() {
        movieLiked ? likeMovieButton.setButtonSF(symbol: "heart.fill") : likeMovieButton.setButtonSF(symbol: "heart")
    }
    
    @IBAction func likeMovie(_ sender: Any) {
        movieLiked.toggle()
    }
}


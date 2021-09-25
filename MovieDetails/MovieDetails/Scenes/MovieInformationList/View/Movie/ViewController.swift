import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var likeMovieButton: UIButton!
    
    @IBOutlet weak var relatedMoviesTableView: UITableView!
    
    let defaults = UserDefaults.standard
    
    var movieLiked: Bool! { didSet { self.changeLikeSymbol() } }
    
    let movieID = 181812
    let key = "76a63be0aae78226a632aacfd082fd6e"
    let movieLikedDefaultKey = "MovieLiked"
    
    let adapter = RelatedMovieAdapter()
    let movieService = MovieService()
    let relatedMoviesService = RelatedMoviesService()
    let saveData = SaveData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromDefault()
        setupAdapter()
        setupScreen()
    }
    
    func loadDataFromDefault() {
        movieLiked = saveData.defaults.bool(forKey: movieLikedDefaultKey)
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
        let posterService = PosterService()
        posterService.fetchMoviePoster(posterPath: movie.poster_path, width: "original") { data in
            self.movieImage.image = UIImage(data: data)
            self.movieImage.showPoster(animationTime: 0.2)
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
        saveData.movieLiked = movieLiked
        saveData.saveInUserDefault(forKey: movieLikedDefaultKey)
    }
    
    @IBAction func likeMovie(_ sender: Any) {
        movieLiked.toggle()
    }
}


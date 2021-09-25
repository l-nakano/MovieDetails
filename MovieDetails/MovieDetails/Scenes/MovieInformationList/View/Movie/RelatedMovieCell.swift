import UIKit

final class RelatedMovieCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    
    func config(using movie: RelatedMovie, withGenres: [Genre]) {
        let genres = withGenres.filter({ movie.genre_ids.contains($0.id) }).map({ $0.name })
        movieTitle.text = movie.original_title
        movieYear.text = String(movie.release_date.prefix(4))
        movieGenres.text = genres.count < 3 ? genres.joined(separator: ", ") : genres[0...1].joined(separator: ", ")
        
        let posterService = PosterService()
        posterService.fetchMoviePoster(posterPath: movie.poster_path, width: "original") { data in
            self.movieImage.image = UIImage(data: data)
            self.movieImage.showPoster(animationTime: 0.2)
        }
    }
}

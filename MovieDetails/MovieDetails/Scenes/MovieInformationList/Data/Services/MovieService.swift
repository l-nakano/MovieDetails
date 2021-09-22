import Foundation

final class MovieService {
    func fetchMoviesDetails() {
        let movieID: Int = 181812
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=76a63be0aae78226a632aacfd082fd6e") else { print("URL inválido")
            return
        }
    }
}

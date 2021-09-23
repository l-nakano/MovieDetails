import Alamofire

final class MovieService {
    func fetchMovieDetails(movieID: Int, key: String, posterWidth: Int, completion: @escaping (Movie, Data) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(key)")
        else {
            print("URL inválido")
            return
        }
        
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                case let .failure(error):
                    fatalError("Erro fetching: \(error)")
                }
            }
            .responseDecodable(of: Movie.self) { response in
                guard let movieDetails = response.value else { return }
                
                let posterService = PosterService()
                posterService.fetchMoviePoster(posterPath: movieDetails.poster_path, width: 500) { data in
                    completion(movieDetails, data)
                }
            }
    }
}

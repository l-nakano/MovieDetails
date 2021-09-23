import Alamofire

final class RelatedMoviesService {
    func fetchRelatedMovies(movieID: Int, key: String, posterWidth: Int, completion: @escaping ([RelatedMovie], [Data]) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/similar?api_key=\(key)&page=1")
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
            .responseDecodable(of: RelatedMoviesResponse.self) { response in
                guard let relatedMovies = response.value else { return }
                
                var posters = [Data]()
                let posterService = PosterService()
                for relatedMovie in relatedMovies.results {
                    guard relatedMovie.poster_path != "" else { continue }
                    posterService.fetchMoviePoster(posterPath: relatedMovie.poster_path, width: 200) { data in
                        posters.append(data)
                    }
                }
                completion(relatedMovies.results, posters)
            }
    }
}

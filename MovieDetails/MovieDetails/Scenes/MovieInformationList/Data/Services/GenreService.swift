import Alamofire

final class GenreService {
    func fetchMovieGenres(key: String, completion: @escaping ([Genre]) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(key)")
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
            .responseDecodable(of: GenresResponse.self) { response in
                guard let genres = response.value else { return }
                completion(genres.genres)
            }
    }
}

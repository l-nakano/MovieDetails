import Alamofire

final class RelatedMoviesService {
    func fetchRelatedMovies(movieID: Int, key: String, completion: @escaping ([RelatedMovie]) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/similar?api_key=\(key)&page=1")
        else {
            print("URL inválido")
            return
        }
        
        DispatchQueue.main.async {
            AF.request(url)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success:
                        print("Related Movie Validation Successful")
                    case let .failure(error):
                        fatalError("Erro fetching: \(error)")
                    }
                }
                .responseDecodable(of: RelatedMoviesResponse.self) { response in
                    guard let relatedMovies = response.value else { return }
                    completion(relatedMovies.results)
                }
        }
    }
}

import Alamofire

final class PosterService {
    func fetchMoviePoster(posterPath: String, width: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/\(width)\(posterPath)")
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
                completion(response.data!)
            }
    }
}

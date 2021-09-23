import Foundation
import Alamofire

final class MovieService {
    func fetchMoviesDetails(completion: @escaping (Movie) -> Void) {
        let movieID: Int = 181812
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=76a63be0aae78226a632aacfd082fd6e")
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
                completion(movieDetails)
            }
    }
    
    func fetchMoviePoster(posterPath: String, width: Int, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w\(width)\(posterPath)")
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

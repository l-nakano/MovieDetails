import Foundation
import Alamofire

final class MovieService {
    func fetchMovieDetails(movieID: Int, posterWidth: Int, completion: @escaping (Movie, Data) -> Void) {
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
                
                self.fetchMoviePoster(posterPath: movieDetails.poster_path, width: 500) { data in
                    completion(movieDetails, data)
                }
            }
    }
    
    private func fetchMoviePoster(posterPath: String, width: Int, completion: @escaping (Data) -> Void) {
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

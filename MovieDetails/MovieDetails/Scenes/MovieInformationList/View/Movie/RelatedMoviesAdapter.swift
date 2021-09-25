import UIKit

final class RelatedMovieAdapter: NSObject, UITableViewDataSource {
    
    var relatedMovies = [RelatedMovie]()
    var genres = [Genre]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        relatedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = relatedMovies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! RelatedMovieCell
        print(cell)
        cell.config(using: movie, withGenres: genres)
        return cell
    }
}

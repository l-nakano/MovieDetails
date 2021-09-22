import UIKit

class MovieDetailsViewController: UIViewController {

    let service = MovieService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        service.fetchMoviesDetails()
    }


}


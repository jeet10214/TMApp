import UIKit

class TrendingMoviesVC: UIViewController {

    var presenter: TrendingMoviesViewOutput!
    var viewState: ViewState = .none
    var moviesViewModel: TrendingMoviesViewModel?
    
    //MARK: VC LifeCycle
    override func loadView() {
        view = UIView()
        navigationItem.title = "Trending Movies"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.getMovies()
    }
}


extension TrendingMoviesVC: TrendingMoviesViewInput {
    func changeViewState(_ state: ViewState) {
        
    }
    
    func displayMovies(with viewModel: TrendingMoviesViewModel) {
        
    }
    
    func insertMovies(with viewModel: TrendingMoviesViewModel, at indexPaths: [IndexPath]) {
        
    }
}

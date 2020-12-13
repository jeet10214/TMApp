import UIKit

class TrendingMoviesVC: UIViewController {

    var presenter: TrendingMoviesViewOutput!
    var viewState: ViewState = .none
    var moviesViewModel: TrendingMoviesViewModel?
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let trendingMovieslayout = UICollectionViewFlowLayout()
        let spacing = Constants.defaultSpacing
        let itemWidth: CGFloat = (UIScreen.main.bounds.width - (Constants.numberOfColumns - spacing) - 2) / Constants.numberOfColumns
        let itemHeight: CGFloat = (itemWidth - Constants.defaultPadding*2) * 1.5 + 63
        trendingMovieslayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        trendingMovieslayout.minimumInteritemSpacing = spacing
        trendingMovieslayout.minimumLineSpacing = spacing
        trendingMovieslayout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return trendingMovieslayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .appBackground()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: VC LifeCycle
    override func loadView() {
        view = UIView()
        view.backgroundColor = .appBackground()
        navigationItem.title = Strings.trendingMoviesTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.getMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollViewDidScroll(collectionView) // for setting nav bar color
    }
    
    private func setupViews() {
        configureCollectionView()
    }
    
    //MARK: ConfigureCollectionView
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.pinEdgesToSuperview()
        collectionView.registerCell(GenericCollectionViewCell<MoviesBannerView>.self)
        collectionView.register(FooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
    }
}


extension TrendingMoviesVC: TrendingMoviesViewInput {
    func changeViewState(_ state: ViewState) {
        viewState = state
        switch state {
        case .loading:
            if moviesViewModel == nil {
                displaySpinner()
            }
        case .content:
            hideSpinner()
            collectionView.collectionViewLayout.invalidateLayout()
        case .errorWith(let message):
            hideSpinner()
            showAlert(title: Strings.error, message: message, retryAction: { [unowned self] in
                self.presenter.getMovies()
            })
        default:
            break
        }
    }
    
    func displayTrendingMovies(with viewModel: TrendingMoviesViewModel) {
        moviesViewModel = viewModel
        collectionView.reloadData()
    }
    
    func insertTrendingMovies(with viewModel: TrendingMoviesViewModel, at indexPaths: [IndexPath]) {
        collectionView.performBatchUpdates({ [weak self] in
            guard let self = self else { return }
            self.moviesViewModel = viewModel
            self.collectionView.insertItems(at: indexPaths)
        })
    }
}

extension TrendingMoviesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = moviesViewModel, !viewModel.isEmpty else {
            return 0
        }
        return viewModel.trendingMoviesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as GenericCollectionViewCell<MoviesBannerView>
        
        guard let viewModel = moviesViewModel else {
            return cell
        }
        let imageWidth = collectionViewLayout.itemSize.width
        let imageSize = CGSize(width: imageWidth, height: imageWidth*1.5)
        
        guard cell.cellView != nil else {
            let cardView = MoviesBannerView(frame: .zero)
            cell.cellView = cardView
            cell.cellView?.movie = viewModel.trendingMovieAt(indexPath.item)
            if let imageURL = viewModel.posterURL(indexPath.item) {
                cell.cellView?.configure(imageURL: imageURL, size: imageSize, indexPath: indexPath)
            }
            return cell
        }
        
        if let imageURL = viewModel.posterURL(indexPath.item) {
            cell.cellView?.configure(imageURL: imageURL, size: imageSize, indexPath: indexPath)
        }
        cell.cellView?.movie = moviesViewModel?.trendingMovieAt(indexPath.item)
        return cell
    }
}

extension TrendingMoviesVC: UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        guard offSetY != 0 else {
            setNavbarTransculent()
            return
        }
        let denominator: CGFloat = 50 //your offset treshold
        let alpha = min(1, offSetY / denominator)
        setNavbar(backgroundColorAlpha: alpha)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectMovie(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let viewModel = moviesViewModel else { return }
        guard viewState != .loading, indexPath.row == (viewModel.trendingMoviesCount - 1) else {
            return
        }
        presenter.getMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewModel = moviesViewModel else { return }
        guard viewState != .loading, indexPath.row == (viewModel.trendingMoviesCount - 1) else {
            return
        }
        if let imageURL = viewModel.posterURL(indexPath.item) {
            ImageDownloader.shared.changeDownloadPriority(for: imageURL)
        }
    }
    
    //MARK: UICollectionViewFooter
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if viewState == .loading && moviesViewModel != nil {
            return CGSize(width: Constants.screenWidth, height: 50)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath) as FooterView
            return footerView
        default:
            assert(false, "Unexpected element kind")
        }
        return UICollectionReusableView()
    }
}

extension UIApplication {
    var statusView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 38482
            if let statusBar = self.keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag

                self.keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
}

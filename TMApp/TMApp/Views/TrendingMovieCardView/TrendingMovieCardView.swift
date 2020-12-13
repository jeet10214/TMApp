//
//  TrendingMovieCardView.swift
//  TMApp
//
//  Created by Jeet Kapadia on 13/12/20.
//

import UIKit

class TrendingMovieCardView: UIView {
    
    // MARK: View Properties
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .appBlack()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(with: .MEDIUM, of: APP_FONT_SIZE.SUB_TITLE)
        return titleLabel
    }()
    
    lazy var trendingMoviePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(with: .SEARCH)
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var movieReleaseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(with: .REEL)
        return imageView
    }()
    
    lazy var movieReleaseDateLabel: UILabel = {
        let movieReleaseDateLabel = UILabel()
        movieReleaseDateLabel.textColor = .appBlack()
        movieReleaseDateLabel.font = UIFont(with: .MEDIUM, of: APP_FONT_SIZE.SMALL)
        return movieReleaseDateLabel
    }()
    
    lazy var ratingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(with: .STAR)
        return imageView
    }()
    
    lazy var ratingMovieCountLabel: UILabel = {
        let ratingMovieCountLabel = UILabel()
        ratingMovieCountLabel.textColor = .appBlack()
        ratingMovieCountLabel.font = UIFont(with: .MEDIUM, of: APP_FONT_SIZE.SMALL)
        return ratingMovieCountLabel
    }()
    
    // MARK: Data Properties
    var movie : TrendingMovie? {
        didSet {
            guard let movie = movie else {
                return
            }
            titleLabel.text = movie.title
            movieReleaseDateLabel.text = movie.release_date
            ratingMovieCountLabel.text = String(format: "%f", movie.popularity ?? 0.0)
        }
    }
    
    // MARK: Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }
    
    // MARK: Private Custom Methods
    private func prepareView() {
        addSubview(trendingMoviePhotoImageView)
        trendingMoviePhotoImageView.pinEdgesEquallyToSuperview(atrributes: [.top, .leading, .trailing], constant: Constants.defaultPadding)
        trendingMoviePhotoImageView.pin(attribute: .height, toView: trendingMoviePhotoImageView, toAttribute: .width, multiplier: 1.5, constant: 0)
        trendingMoviePhotoImageView.giveCorner(radius: Constants.defaultRadius)
        
        addSubview(titleLabel)
        titleLabel.pinTo(atrribute: .top, toView: trendingMoviePhotoImageView, toAttribute: .bottom, constant: Constants.defaultSpacing)
        titleLabel.pinEdgesEquallyToSuperview(atrributes: [.leading, .trailing], constant: Constants.defaultPadding)
        
        addSubview(movieReleaseImageView)
        movieReleaseImageView.pinTo(atrribute: .top, toView: titleLabel, toAttribute: .bottom, constant: Constants.defaultPadding)
        movieReleaseImageView.pinEdgesEquallyToSuperview(atrributes: [.leading], constant: Constants.defaultPadding + 50)
        movieReleaseImageView.pinHeightWidth(constant: 14)
        
        addSubview(movieReleaseDateLabel)
        movieReleaseDateLabel.pinTo(atrribute: .top, toView: titleLabel, toAttribute: .bottom, constant: Constants.defaultPadding + 1)
        movieReleaseDateLabel.pinTo(atrribute: .leading, toView: movieReleaseImageView, toAttribute: .trailing, constant: Constants.defaultPadding)
        movieReleaseDateLabel.pinEdgesEquallyToSuperview(atrributes: [.trailing], constant: Constants.defaultPadding)
        movieReleaseDateLabel.pinHeight(14)
        
        
        addSubview(ratingImageView)
        ratingImageView.pinTo(atrribute: .top, toView: movieReleaseDateLabel, toAttribute: .bottom, constant: Constants.defaultPadding)
        ratingImageView.pinEdgesEquallyToSuperview(atrributes: [.leading], constant: Constants.defaultPadding + 50)
        ratingImageView.pinHeightWidth(constant: 14)
        
        addSubview(ratingMovieCountLabel)
        ratingMovieCountLabel.pinTo(atrribute: .top, toView: movieReleaseDateLabel, toAttribute: .bottom, constant: Constants.defaultPadding + 1)
        ratingMovieCountLabel.pinTo(atrribute: .leading, toView: ratingImageView, toAttribute: .trailing, constant: Constants.defaultPadding)
        ratingMovieCountLabel.pinEdgesEquallyToSuperview(atrributes: [.trailing], constant: Constants.defaultPadding)
        movieReleaseDateLabel.pinHeight(14)
        
    }
    
    // MARK: Methods
    /// display movies
    /// - Parameters:
    ///   - imageURL: link for image
    ///   - size: size for the image
    ///   - indexPath: indexPath of list
    func configure(imageURL: URL, size: CGSize, indexPath: IndexPath) {
        trendingMoviePhotoImageView.loadImage(with: imageURL, size: size, indexPath: indexPath)
    }
}

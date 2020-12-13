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
    
    lazy var languageLabel: UILabel = {
        let languageLabel = UILabel()
        languageLabel.textAlignment = .right
        languageLabel.textColor = .appBlack()
        languageLabel.font = UIFont(with: .BOLD, of: APP_FONT_SIZE.SMALL)
        return languageLabel
    }()
    
    lazy var likedPercentageView: UIView = {
        let likePercentageView  = UIView()
        likePercentageView.clipsToBounds = true
        return likePercentageView
    }()
    
    lazy var likedPercentageLabel: UILabel = {
        let likedPercentageLabel = UILabel()
        likedPercentageLabel.textAlignment = .center
        likedPercentageLabel.textColor = .black
        likedPercentageLabel.font = UIFont(with: .MEDIUM, of: APP_FONT_SIZE.SMALL)
        return likedPercentageLabel
    }()
    
    lazy var voteCountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(with: .STAR)
        return imageView
    }()
    
    lazy var voteCountLabel: UILabel = {
        let voteCountLabel = UILabel()
        voteCountLabel.textColor = .appBlack()
        voteCountLabel.font = UIFont(with: .BOLD, of: APP_FONT_SIZE.SMALL)
        return voteCountLabel
    }()
    
    lazy var adultMovieLabel: UILabel = {
        let adultMovieLabel = UILabel()
        adultMovieLabel.textAlignment = .right
        adultMovieLabel.textColor = .appBlack()
        adultMovieLabel.font = UIFont(with: .MEDIUM, of: APP_FONT_SIZE.SMALL)
        return adultMovieLabel
    }()
    
    // MARK: Data Properties
    var movie : TrendingMovie? {
        didSet {
            guard let movie = movie else {
                return
            }
            titleLabel.text = movie.title
            
            movieReleaseDateLabel.text = movie.release_date?.getDisplayableDateFormat(movie.release_date ?? "")
            languageLabel.text = movie.original_language?.uppercased()
            likedPercentageView.backgroundColor = Int(movie.vote_average ?? 0) * 10 > 60 ? .green : .yellow
            likedPercentageLabel.text = String(Int(movie.vote_average ?? 0) * 10) + "%"
            voteCountLabel.text = String(movie.vote_count ?? 0)
            adultMovieLabel.text = movie.adult ?? false ? "A" : "U/A"
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
        
        //1
        addSubview(trendingMoviePhotoImageView)
        trendingMoviePhotoImageView.pinEdgesEquallyToSuperview(atrributes: [.top, .leading, .trailing], constant: Constants.defaultPadding)
        trendingMoviePhotoImageView.pin(attribute: .height, toView: trendingMoviePhotoImageView, toAttribute: .width, multiplier: 1.5, constant: 0)
        trendingMoviePhotoImageView.giveCorner(radius: Constants.defaultRadius)

        let releaseDateStackView = UIStackView()
        addSubview(releaseDateStackView)
        releaseDateStackView.addArrangedSubview(movieReleaseImageView)
        releaseDateStackView.addArrangedSubview(movieReleaseDateLabel)
        releaseDateStackView.axis = .horizontal
        releaseDateStackView.spacing = 4
        movieReleaseImageView.pinHeightWidth(constant: 14)
        releaseDateStackView.pinTo(atrribute: .top, toView: trendingMoviePhotoImageView, toAttribute: .bottom, constant: Constants.defaultSpacing)
        releaseDateStackView.pinEdgesEquallyToSuperview(atrributes: [.leading], constant: Constants.defaultPadding)
        releaseDateStackView.pinHeight(14)
        
        addSubview(languageLabel)
        languageLabel.pinTo(atrribute: .top, toView: trendingMoviePhotoImageView, toAttribute: .bottom, constant: Constants.defaultSpacing)
        languageLabel.pinTo(atrribute: .leading, toView: releaseDateStackView, toAttribute: .trailing, constant: Constants.defaultPadding)
        languageLabel.pinEdgesEquallyToSuperview(atrributes: [.trailing], constant: Constants.defaultPadding)
        
        let voteCountStackView = UIStackView()
        addSubview(voteCountStackView)
        voteCountStackView.addArrangedSubview(voteCountImageView)
        voteCountStackView.addArrangedSubview(voteCountLabel)
        voteCountStackView.axis = .horizontal
        voteCountStackView.spacing = 4
        movieReleaseImageView.pinHeightWidth(constant: 14)
        voteCountStackView.pinTo(atrribute: .top, toView: releaseDateStackView, toAttribute: .bottom, constant: Constants.defaultSpacing + 5)
        voteCountStackView.pinEdgesEquallyToSuperview(atrributes: [.leading], constant: Constants.defaultPadding)
        voteCountStackView.pinHeight(14)
        
        addSubview(adultMovieLabel)
        adultMovieLabel.pinTo(atrribute: .top, toView: releaseDateStackView, toAttribute: .bottom, constant: Constants.defaultSpacing)
        adultMovieLabel.pinTo(atrribute: .leading, toView: voteCountStackView, toAttribute: .trailing, constant: Constants.defaultPadding)
        adultMovieLabel.pinEdgesEquallyToSuperview(atrributes: [.trailing], constant: Constants.defaultPadding)
        
        
        addSubview(likedPercentageView)
        likedPercentageView.pinTo(atrribute: .top, toView: trendingMoviePhotoImageView, toAttribute: .top, constant: Constants.defaultPadding)
        likedPercentageView.pinTo(atrribute: .trailing, toView: trendingMoviePhotoImageView, toAttribute: .trailing, constant: -Constants.defaultPadding)
        likedPercentageView.pinHeightWidth(constant: 30)
        likedPercentageView.giveCorner(radius: 15)
        
        likedPercentageView.addSubview(likedPercentageLabel)
        likedPercentageLabel.pinEdgesEquallyToSuperview(atrributes: [.top, .leading, .trailing, .bottom], constant: 0)
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

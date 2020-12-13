//
//  MoviesBannerView.swift
//  TMApp
//
//  Created by Jeet Kapadia on 13/12/20.
//

import UIKit

class MoviesBannerView: UIView {
    
    // MARK: View Properties
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .appBlack()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(with: .MEDIUM, of: APP_FONT_SIZE.SUB_TITLE)
        return titleLabel
    }()
    
    lazy var moviePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(with: .SEARCH)
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var movieReleaseIcon: UIImageView = {
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
    
    lazy var voteCountIcon: UIImageView = {
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
    ///PrepareView:
    ///1:  moviePhotoImageView to view for displaying poster data
    ///2:  Stackview to view which contains
        ///-releaseDateIcon
        ///-releaseDateLabel
    ///3:  languageLabel to display the movie's avaialable language
    ///4: StackView to view which contains
        ///-voteCountIcon
        ///-voteCountLabel
    ///5: adultMovieLabel to display movie's content is suitable for children
    ///6: likedPercentage view to display the average vote rating of users
    private func prepareView() {
        
        //1
        addSubview(moviePhotoImageView)
        moviePhotoImageView.pinEdgesEquallyToSuperview(atrributes: [.top, .leading, .trailing], constant: Constants.defaultPadding)
        moviePhotoImageView.pin(attribute: .height, toView: moviePhotoImageView, toAttribute: .width, multiplier: 1.5, constant: 0)
        moviePhotoImageView.giveCorner(radius: Constants.defaultRadius)

        //2
        let releaseDateStackView = UIStackView()
        addSubview(releaseDateStackView)
        releaseDateStackView.addArrangedSubview(movieReleaseIcon)
        releaseDateStackView.addArrangedSubview(movieReleaseDateLabel)
        releaseDateStackView.setAxisAndSpacing()
        movieReleaseIcon.pinHeightWidth(constant: 14)
        releaseDateStackView.pinTo(atrribute: .top, toView: moviePhotoImageView, toAttribute: .bottom, constant: Constants.defaultSpacing)
        releaseDateStackView.pinEdgesEquallyToSuperview(atrributes: [.leading], constant: Constants.defaultPadding)
        releaseDateStackView.pinHeight(14)
        
        //3
        addSubview(languageLabel)
        languageLabel.pinTo(atrribute: .top, toView: moviePhotoImageView, toAttribute: .bottom, constant: Constants.defaultSpacing)
        languageLabel.pinTo(atrribute: .leading, toView: releaseDateStackView, toAttribute: .trailing, constant: Constants.defaultPadding)
        languageLabel.pinEdgesEquallyToSuperview(atrributes: [.trailing], constant: Constants.defaultPadding)
        
        //4
        let voteCountStackView = UIStackView()
        addSubview(voteCountStackView)
        voteCountStackView.addArrangedSubview(voteCountIcon)
        voteCountStackView.addArrangedSubview(voteCountLabel)
        voteCountStackView.setAxisAndSpacing()
        movieReleaseIcon.pinHeightWidth(constant: 14)
        voteCountStackView.pinTo(atrribute: .top, toView: releaseDateStackView, toAttribute: .bottom, constant: Constants.defaultSpacing + 5)
        voteCountStackView.pinEdgesEquallyToSuperview(atrributes: [.leading], constant: Constants.defaultPadding)
        voteCountStackView.pinHeight(14)
        
        //5
        addSubview(adultMovieLabel)
        adultMovieLabel.pinTo(atrribute: .top, toView: releaseDateStackView, toAttribute: .bottom, constant: Constants.defaultSpacing)
        adultMovieLabel.pinTo(atrribute: .leading, toView: voteCountStackView, toAttribute: .trailing, constant: Constants.defaultPadding)
        adultMovieLabel.pinEdgesEquallyToSuperview(atrributes: [.trailing], constant: Constants.defaultPadding)
        
        //6
        addSubview(likedPercentageView)
        likedPercentageView.pinTo(atrribute: .top, toView: moviePhotoImageView, toAttribute: .top, constant: Constants.defaultPadding)
        likedPercentageView.pinTo(atrribute: .trailing, toView: moviePhotoImageView, toAttribute: .trailing, constant: -Constants.defaultPadding)
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
        moviePhotoImageView.loadImage(with: imageURL, size: size, indexPath: indexPath)
    }
}

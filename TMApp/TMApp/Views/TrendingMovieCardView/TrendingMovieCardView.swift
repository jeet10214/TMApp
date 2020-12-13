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
    
    // MARK: Data Properties
    var movie : TrendingMovie? {
        didSet {
            guard let movie = movie else {
                return
            }
            titleLabel.text = movie.title
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

//
//  HomeCollectionViewCell.swift
//  instalite
//
//  Created by Veera on 11/12/22.
//

import UIKit
import SDWebImage

class HomeCollectionViewCell: UICollectionViewCell {
    private struct Constants {
        static let placeHolderImage = "photo"
        static let albumImage = "person.2.crop.square.stack"
    }
    
    private lazy var mediaImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var mediaTypeImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .theme(.imageTint)
        
        return imageView
    }()
    
    // MARK: View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Methods
    
    func setup(with mediaItem: MediaItem) {
        mediaImageView.sd_setImage(with: mediaItem.mediaURL.url, placeholderImage: UIImage(systemName: Constants.placeHolderImage))
        
        guard mediaItem.isAlbum else {
            mediaTypeImageView.isHidden = true
            return
        }
        
        mediaTypeImageView.image = UIImage(systemName: Constants.albumImage)
    }
    
    // MARK: Private methods
    
    private func configureView() {
        contentView.addSubview(mediaImageView)
        contentView.addSubview(mediaTypeImageView)
    }
    
    private func configureConstraints() {
        mediaImageView.pinToSuperviewEdges()
        
        mediaTypeImageView.activate(constraints: [
            mediaTypeImageView.heightAnchor.constraint(equalToConstant: 24),
            mediaTypeImageView.widthAnchor.constraint(equalToConstant: 24),
            mediaTypeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mediaTypeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
}

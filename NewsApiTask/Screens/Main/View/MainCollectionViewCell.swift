//
//  MainCollectionViewCell.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell, CollectionViewCellProtocol {
    // MARK: - Nested Types
    struct Model: CollectionViewCellModelProtocol {
        var callbackAction: ((Model) -> Void)?
        let title: String
        let image: UIImage
        
        init(title: String, image: UIImage) {
            self.title = title
            self.image = image
        }
    }
    
    private enum Constants {
        static let cornerRadius: CGFloat = 20
        static let cellBackgroundColor: UIColor = .purple.withAlphaComponent(0.1)
    }
    
    // MARK: - Properties
    var model: Model! {
        didSet {
            titleLabel.text = model.title
            imageView.image = model.image
        }
    }
    
    // MARK: - UIProperties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView.autoLayout()
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label.autoLayout()
    }()
    
    // MARK: - Initialization
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupLayout()
        setupCustomization()
    }

    // MARK: - Private Methods
    private func setupSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width * 0.9),
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.6),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    private func setupCustomization() {
        backgroundColor = Constants.cellBackgroundColor
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = true
    }
}

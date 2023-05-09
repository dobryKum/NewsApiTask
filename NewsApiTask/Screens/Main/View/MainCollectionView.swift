//
//  MainCollectionView.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import UIKit

final class MainCollectionView: CollectionView {
    // MARK: - Nested Types
    private enum Constants {
        static let normalInset: CGFloat = 16
    }

    // MARK: - Properties
    var callbackDidSelectItem: ((IndexPath) -> Void)?

    var sectionsData: [Main.CollectionView.Section] = [] {
        didSet {
            setupSections()
        }
    }

    // MARK: - Initialization
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
        configureCollection()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented in SMMainCollectionView")
    }

    // MARK: - Private Methods
    private func configureCollection() {
        registerCells([MainCollectionViewCell.self])
    }

    private func setupSections() {
        sections = sectionsData.map { section in
            let rows: [CollectionViewItemProtocol] = section.items.map { item in
                let cellModel = MainCollectionViewCell.Model(title: item.title,
                                                             image: item.image)
                return CollectionViewItem<MainCollectionViewCell, MainCollectionViewCell.Model>(cellModel)
            }
            return CollectionViewSection(title: section.title, items: rows)
        }
    }

    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        callbackDidSelectItem?(indexPath)
    }
    
    // MARK: - Flow Layout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: Constants.normalInset,
                     left: Constants.normalInset,
                     bottom: Constants.normalInset,
                     right: Constants.normalInset)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.normalInset
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.normalInset
    }
}

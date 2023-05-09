//
//  CollectionViewItem.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import UIKit

final class CollectionViewItem<
    ViewType: CollectionViewCellProtocol,
    DataType: CollectionViewCellModelProtocol
>: CollectionViewItemProtocol where ViewType.DataType == DataType, ViewType: UIView {
    // MARK: - Properties
    static var cellReuseIdentifier: String { return String(describing: ViewType.self) }
    var viewType: UIView.Type { ViewType.self }
    let model: DataType

    // MARK: - Initialization
    public init(_ model: DataType) {
        self.model = model
    }

    // MARK: - Configure
    func configure(view: UIView) {
        guard var view = (view as? ViewType) else { return }
        view.model = model
    }
}

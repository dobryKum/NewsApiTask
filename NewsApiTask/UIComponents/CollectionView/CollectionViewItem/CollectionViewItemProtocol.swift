//
//  CollectionViewItemProtocol.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import UIKit

protocol CollectionViewItemProtocol {
    static var cellReuseIdentifier: String { get }
    var viewType: UIView.Type { get }
    func configure(view: UIView)
}

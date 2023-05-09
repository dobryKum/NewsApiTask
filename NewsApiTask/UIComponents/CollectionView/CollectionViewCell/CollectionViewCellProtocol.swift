//
//  CollectionViewCellProtocol.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import Foundation

protocol CollectionViewCellProtocol {
    associatedtype DataType
    var model: DataType! { get set }
}

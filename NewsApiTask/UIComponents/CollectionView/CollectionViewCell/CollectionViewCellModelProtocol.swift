//
//  CollectionViewCellModelProtocol.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import Foundation

protocol CollectionViewCellModelProtocol {
    associatedtype DataType
    var callbackAction: ((DataType) -> Void)? { get set }
}

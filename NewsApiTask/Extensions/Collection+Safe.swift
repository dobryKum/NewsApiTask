//
//  Collection+Safe.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

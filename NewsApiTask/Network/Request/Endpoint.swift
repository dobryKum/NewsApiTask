//
//  Endpoint.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 4.05.23.
//

import Foundation

protocol Endpoint {
    var compositePath: String { get }
    var queryItems: HTTPQueryItems? { get }
}

extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = NetworkConstants.URLComponents.scheme
        urlComponents.path = NetworkConstants.URLComponents.basePath + compositePath
        urlComponents.queryItems = queryItems?.map {
            let item = URLQueryItem(name: $0, value: $1)
            return item
        }
        return urlComponents.url
    }
}

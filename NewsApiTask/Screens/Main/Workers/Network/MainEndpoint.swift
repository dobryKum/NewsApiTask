//
//  MainEndpoint.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import Foundation

enum MainEndpoint: Endpoint {
    case topHeadlines(page: Int)
    
    var queryItems: HTTPQueryItems? {
        switch self {
        case .topHeadlines(let page):
            return ["language": "en",
                    "page": "\(page)"]
        }
    }
    
    var compositePath: String {
        return basePath
    }

    private var basePath: String {
        switch self {
        default:
            return "/top-headlines"
        }
    }
}

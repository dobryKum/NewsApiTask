//
//  HTTPError.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 4.05.23.
//

import Foundation

enum HTTPError: Error {
    case networkError(Error)
    case parsingError
    case timeout
    case unsuccessStatus(Int)
    case incorrectUrl
    case imageDownloadingFail
    case undefined
}

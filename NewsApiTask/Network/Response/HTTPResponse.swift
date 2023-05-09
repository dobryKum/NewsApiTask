//
//  HTTPResponse.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 4.05.23.
//

import Foundation

struct HTTPResponse {
    let statusCode: Int
    let headers: HTTPHeaders
    let data: Data?

    init(statusCode: Int,
         headers: HTTPHeaders,
         data: Data?) {
        self.statusCode = statusCode
        self.headers = headers
        self.data = data
    }
}

//
//  NetworkContainer.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 4.05.23.
//

import Foundation

final class NetworkContainer {
    // MARK: - Shared
    static let shared = NetworkContainer()
    
    // MARK: - Properties
    let httpClient: HTTPClientProtocol
    let imageDownloader: ImageDownloaderProtocol
    
    // MARK: - Initialization
    private init(httpClient: HTTPClientProtocol = HTTPClient(),
                 imageDownloader: ImageDownloaderProtocol = ImageDownloader()) {
        self.httpClient = httpClient
        self.imageDownloader = imageDownloader
    }
}

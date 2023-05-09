//
//  MainNetworkWorker.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import Foundation

final class MainNetworkWorker: MainNetworkWorkerLogic {
    // MARK: - Properties
    private let httpClient: HTTPClientProtocol
    private let imageDownloader: ImageDownloaderProtocol
    
    // MARK: - Initialization
    init(httpClient: HTTPClientProtocol = NetworkContainer.shared.httpClient,
         imageDownloader: ImageDownloaderProtocol = NetworkContainer.shared.imageDownloader) {
        self.httpClient = httpClient
        self.imageDownloader = imageDownloader
    }
    
    // MARK: - MainNetworkWorkerLogic
    func loadArticles(completion: @escaping ((Result<MainDTO.Response, HTTPError>) -> Void)) {
        let request = HTTPRequest(endpoint: MainEndpoint.topHeadlines(page: 1),
                                  method: .get,
                                  headers: ["X-API-Key": NetworkConstants.Environment.apiKey])
        
        httpClient.request(request: request) { result in
            let completion = { response in
                DispatchQueue.main.async { completion(response) }
            }
            switch result {
            case .success(let response):
                guard
                    response.statusCode == 200,
                    let data = response.data
                else {
                    completion(.failure(.unsuccessStatus(response.statusCode)))
                    return
                }
                do {
                    let response: MainDTO.Response = try JSONDecoder().decode(MainDTO.Response.self,
                                                                              from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.parsingError))
                }
            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
    }
    
    func loadImages(with articles: [MainDTO.Article],
                    completion: @escaping (Result<[String:Data], HTTPError>) -> Void) {
        var temporaryDictStorage: [String:Data] = [:]
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        let group = DispatchGroup()
        
        queue.async {
            articles.forEach { article in
                guard let imagePath = article.imagePath,
                      let url = URL(string: imagePath) else {
                    completion(.failure(.incorrectUrl))
                    return
                }
                
                group.enter()
                
                self.imageDownloader.fetchImage(with: url) { result in
                    switch result {
                    case .success(let data):
                        temporaryDictStorage[imagePath] = data
                        group.leave()
                    case .failure:
                        completion(.failure(.imageDownloadingFail))
                        return
                    }
                }
            }
            
            group.notify(queue: .main) {
                completion(.success(temporaryDictStorage))
            }
        }
    }
}

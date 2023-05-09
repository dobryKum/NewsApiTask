//
//  ImageDownloader.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 4.05.23.
//

import Foundation

protocol ImageDownloaderProtocol: AnyObject {
    func fetchImage(with url: URL, completion: @escaping (Result<Data, HTTPError>) -> Void)
}

final class ImageDownloader: ImageDownloaderProtocol {
    func fetchImage(with url: URL, completion: @escaping (Result<Data, HTTPError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                let data = data,
                error == nil
            else {
                completion(.failure(.imageDownloadingFail))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }
}

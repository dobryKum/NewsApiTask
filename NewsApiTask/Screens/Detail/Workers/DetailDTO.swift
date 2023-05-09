//
//  DetailDTO.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 9.05.23.
//

import Foundation

enum DetailDTO {
    struct Article: Codable {
        let author: String?
        let title: String
        let subtitle: String?
        let imagePath: String?
        let content: String?
        let url: URL?

        enum CodingKeys: String, CodingKey {
            case author, title, content, url
            case imagePath = "urlToImage"
            case subtitle = "description"
        }
    }
}

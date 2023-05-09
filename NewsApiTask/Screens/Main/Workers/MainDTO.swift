//
//  MainDTO.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import UIKit

enum MainDTO {
    struct Response: Decodable {
        let articles: [Article]
    }
    
    struct Article: Decodable, Equatable {
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
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            let lhsTitle = lhs.title.replacingOccurrences(of: "\\", with: "")
            let rhsTitle = rhs.title.replacingOccurrences(of: "\\", with: "")
            return lhsTitle == rhsTitle
        }
    }
    
    struct ImageFile {
        let image: UIImage
        let path: String
    }
}

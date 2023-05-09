//
//  DetailModels.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 9.05.23.
//

import UIKit

enum Detail {
    enum Initial {
        struct Request {}
        
        struct Response {
            let title: String
            let subtitle: String?
            let image: UIImage
            let url: URL?
        }
        
        struct ViewModel {
            let title: String
            let subtitle: String?
            let image: UIImage
            let url: URL?
        }
    }
    
    enum Error {
        struct Request {}
        struct Response {}
        
        struct ViewModel {
            let title: String
            let subtitle: String
            let buttonText: String
        }
    }
}

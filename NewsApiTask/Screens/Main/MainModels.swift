//
//  MainModels.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import UIKit

enum Main {
    enum Initial {
        struct Request {}
        
        struct Response {
            let articles: [Article]
            
            struct Article {
                let title: String
                let image: UIImage
            }
        }
        
        struct ViewModel {
            let articles: [Article]
            
            struct Article {
                let title: String
                let image: UIImage
            }
        }
    }
    
    enum DataTransmission {
        struct Request {
            let articleTitle: String
        }
        
        struct Response {}
        struct ViewModel {}
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
    
    enum CollectionView {
        struct Section {
            let title: String
            let items: [Item]
        }
        
        struct Item {
            let title: String
            let image: UIImage
        }
    }
    
    // MARK: - DataToDetailScreen
    struct DetatilDataTransmissionModel {
        let articleTitle: String
    }
}

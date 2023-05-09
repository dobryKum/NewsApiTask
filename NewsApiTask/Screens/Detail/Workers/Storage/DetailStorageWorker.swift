//
//  DetailStorageWorker.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 9.05.23.
//

import UIKit

final class DetailStorageWorker: DetailStorageWorkerLogic {
    // MARK: - Properties
    private let coreDataService: CoreDataService
    private let fileService: FileServiceProtocol
    
    // MARK: - Initialization
    init(
        coreDataService: CoreDataService = StorageContainer.shared.coreDataService,
         fileService: FileServiceProtocol = StorageContainer.shared.fileService) {
        self.coreDataService = coreDataService
        self.fileService = fileService
    }
    
    // MARK: - DetailStorageWorkerLogic
    func getArticle(by primaryKey: String) -> DetailDTO.Article? {
        guard let managedObject = getArticleObject(by: primaryKey) else { return nil }

        return DetailDTO.Article(author: managedObject.author,
                                 title: managedObject.title,
                                 subtitle: managedObject.subtitle,
                                 imagePath: managedObject.imagePath,
                                 content: managedObject.content,
                                 url: managedObject.url)
    }
    
    func getArticleObject(by primaryKey: String) -> ArticleManagedObject? {
        let predicate = NSPredicate(format: "title == %@", primaryKey)
        let managedObjects: [ArticleManagedObject] = coreDataService.fetch(with: predicate)
        return managedObjects.first
    }
    
    func getImage(by path: String) -> UIImage {
        fileService.getImage(path: path) ?? UIImage()
    }
}

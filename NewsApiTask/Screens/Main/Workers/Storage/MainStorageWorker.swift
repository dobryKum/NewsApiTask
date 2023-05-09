//
//  MainStorageWorker.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import UIKit

final class MainStorageWorker {
    // MARK: - Properties
    private let coreDataService: CoreDataService
    private let fileService: FileServiceProtocol
    
    // MARK: - Initialization
    init(coreDataService: CoreDataService = StorageContainer.shared.coreDataService,
         fileService: FileServiceProtocol = StorageContainer.shared.fileService) {
        self.coreDataService = coreDataService
        self.fileService = fileService
    }
    
    // MARK: - Private Methods
    private func saveArticle(with dto: MainDTO.Article) {
        let articleManagedObject: ArticleManagedObject = coreDataService.create()
        articleManagedObject.author = dto.author
        articleManagedObject.title = dto.title
        articleManagedObject.subtitle = dto.subtitle
        articleManagedObject.imagePath = dto.imagePath
        articleManagedObject.content = dto.content
        articleManagedObject.url = dto.url
        coreDataService.save()
    }
    
    private func saveArticles(with articleDTOs: [MainDTO.Article]) {
        articleDTOs.forEach {
            saveArticle(with: $0)
        }
    }
    
    private func convertManagedObjectsToDTOs(with managedObjects: [ArticleManagedObject]) -> [MainDTO.Article] {
        managedObjects.map { articleObject in
            MainDTO.Article(author: articleObject.author,
                            title: articleObject.title,
                            subtitle: articleObject.subtitle,
                            imagePath: articleObject.imagePath,
                            content: articleObject.content,
                            url: articleObject.url)
        }
    }
    
    private func convertDTOToManagedObject(with dto: MainDTO.Article) -> ArticleManagedObject {
        let articleManagedObject: ArticleManagedObject = coreDataService.create()
        articleManagedObject.author = dto.author
        articleManagedObject.title = dto.title
        articleManagedObject.subtitle = dto.subtitle
        articleManagedObject.imagePath = dto.imagePath
        articleManagedObject.content = dto.content
        articleManagedObject.url = dto.url
        return articleManagedObject
    }
}

// MARK: - MainStorageWorkerLogic
extension MainStorageWorker: MainStorageWorkerLogic {
    func getArticles() -> [MainDTO.Article] {
        let articles: [ArticleManagedObject] = coreDataService.fetchAll()
        let articleDTOs: [MainDTO.Article] = articles.map { articleObject in
            MainDTO.Article(author: articleObject.author,
                            title: articleObject.title,
                            subtitle: articleObject.subtitle,
                            imagePath: articleObject.imagePath,
                            content: articleObject.content,
                            url: articleObject.url)
        }
        return articleDTOs
    }
    
    // Completion is used to save images for new elements
    func proccessArticles(with articleDTOs: [MainDTO.Article], completion: @escaping (([MainDTO.Article]) -> Void)) {
        let articleDTOs = articleDTOs.filter { $0.imagePath != nil && $0.url != nil }
        let articleObjects: [ArticleManagedObject] = coreDataService.fetchAll()
        var nonStoredArticleDTOs: [MainDTO.Article] = []
        
        if articleObjects.isEmpty {
            saveArticles(with: articleDTOs)
            completion(articleDTOs)
        } else {
            // Check stored items for non-matches
            let storedArticleDTOs = convertManagedObjectsToDTOs(with: articleObjects)
            articleDTOs.forEach { articleDTO in
                if !storedArticleDTOs.contains(articleDTO) {
                    saveArticle(with: articleDTO)
                    nonStoredArticleDTOs.append(articleDTO)
                }
            }
            completion(nonStoredArticleDTOs)
        }
    }
    
    func saveImages(with imageFiles: [MainDTO.ImageFile]) {
        imageFiles.forEach { imageFile in
            fileService.saveImage(path: imageFile.path, image: imageFile.image)
        }
    }
    
    func getImage(by path: String) -> UIImage {
        fileService.getImage(path: path) ?? UIImage()
    }
}

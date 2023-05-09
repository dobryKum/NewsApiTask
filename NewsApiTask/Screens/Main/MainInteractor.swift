//
//  MainInteractor.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import UIKit

final class MainInteractor: MainDataStore {
    // MARK: - Properties
    var data: Main.DetatilDataTransmissionModel?
    
    private let presenter: MainPresentationLogic
    private let networkWorker: MainNetworkWorkerLogic
    private let storageWorker: MainStorageWorkerLogic
    
    // MARK: - Initialization
    init(presenter: MainPresentationLogic,
         networkWorker: MainNetworkWorkerLogic,
         storageWorker: MainStorageWorkerLogic) {
        self.presenter = presenter
        self.networkWorker = networkWorker
        self.storageWorker = storageWorker
    }
    
    // MARK: - Private Methods
    private func createImageFiles(with articles: [Main.Initial.Response.Article]) -> [MainDTO.ImageFile] {
        articles.map { article in
            return MainDTO.ImageFile(image: article.image, path: article.title)
        }
    }
    
    private func convertArticleDTOsToArticle(with articleDTOs: [MainDTO.Article],
                                             imagesData: [String:Data]) -> [Main.Initial.Response.Article] {
        var articles: [Main.Initial.Response.Article] = []
        
        articleDTOs.forEach { articleDTO in
            guard let imagePath = articleDTO.imagePath,
                let imageData = imagesData[imagePath],
                let image = UIImage(data: imageData)
            else { return }
            
            let article = Main.Initial.Response.Article(title: articleDTO.title,
                                                        image: image)
            articles.append(article)
        }
        return articles
    }
    
    private func saveImages(with articleDTOs: [MainDTO.Article],
                            and temporaryStorage: [String: Data]) {
        let articles = convertArticleDTOsToArticle(with: articleDTOs,
                                                   imagesData: temporaryStorage)
        let imageFiles = createImageFiles(with: articles)
        storageWorker.saveImages(with: imageFiles)
    }
    
    private func loadImages(for articleDTOs: [MainDTO.Article]) {
        networkWorker.loadImages(with: articleDTOs) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let temporaryDictStorage):
                self.saveImages(with: articleDTOs, and: temporaryDictStorage)
                self.loadArticlesFromStorage()
            case .failure:
                self.loadArticlesFromStorage()
            }
        }
    }
    
    private func loadImage(for articleDTO: MainDTO.Article) {
        loadImages(for: [articleDTO])
    }
    
    private func loadArticlesFromStorage() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let articleDTOs = self.storageWorker.getArticles()
            
            if articleDTOs.isEmpty {
                self.presenter.presentError(Main.Error.Response())
                return
            }
            
            let articles: [Main.Initial.Response.Article] = articleDTOs.map { dto in
                Main.Initial.Response.Article(
                    title: dto.title,
                    image: self.storageWorker.getImage(by: dto.title)
                )
            }
            
            let response = Main.Initial.Response(articles: articles)
            self.presenter.presentInitialData(response)
        }
    }
    
    private func processReceivedArticles(with articles: [MainDTO.Article]) {
        storageWorker.proccessArticles(with: articles) { [weak self] nonStoredArticleDTOs in
            guard let self = self else { return }
            if nonStoredArticleDTOs.isEmpty {
                self.loadArticlesFromStorage()
            } else {
                self.loadImages(for: nonStoredArticleDTOs)
            }
        }
    }
}

// MARK: - MainBusinessLogic
extension MainInteractor: MainBusinessLogic {
    func requestInitialData(_ request: Main.Initial.Request) {
        networkWorker.loadArticles { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.processReceivedArticles(with: response.articles)
            case .failure:
                self.loadArticlesFromStorage()
            }
        }
    }
    
    func requestDataTransmission(_ request: Main.DataTransmission.Request) {
        data = Main.DetatilDataTransmissionModel(articleTitle: request.articleTitle)
        presenter.presentDataTransmission(Main.DataTransmission.Response())
    }
    
    func requestError(_ request: Main.Error.Request) {
        presenter.presentError(Main.Error.Response())
    }
}

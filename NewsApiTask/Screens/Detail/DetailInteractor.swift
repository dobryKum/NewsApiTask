//
//  DetailInteractor.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 9.05.23.
//

import Foundation

final class DetailInteractor {
    // MARK: - Properties
    var data: Main.DetatilDataTransmissionModel
    
    private let presenter: DetailPresentationLogic
    private let storageWorker: DetailStorageWorkerLogic
    
    // MARK: - Initialization
    init(
        presenter: DetailPresentationLogic,
        storageWorker: DetailStorageWorkerLogic,
        data: Main.DetatilDataTransmissionModel
    ) {
        self.presenter = presenter
        self.storageWorker = storageWorker
        self.data = data
    }
}

// MARK: - DetailBusinessLogic
extension DetailInteractor: DetailBusinessLogic {
    func requestInitialData(_ request: Detail.Initial.Request) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            guard let articleObject = self.storageWorker.getArticle(by: data.articleTitle) else {
                self.presenter.presentError(Detail.Error.Response())
                return
            }
            self.presenter.presentInitialData(Detail.Initial.Response(title: articleObject.title,
                                                                      subtitle: articleObject.subtitle,
                                                                      image: self.storageWorker.getImage(by: articleObject.title),
                                                                      url: articleObject.url))
        }
    }
    
    func requestError(_ request: Detail.Error.Request) {
        presenter.presentError(Detail.Error.Response())
    }
}

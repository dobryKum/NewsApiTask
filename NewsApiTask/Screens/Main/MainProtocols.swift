//
//  MainProtocols.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import UIKit

// MARK: - BusinessLogic
protocol MainBusinessLogic: AnyObject {
    func requestInitialData(_ request: Main.Initial.Request)
    func requestDataTransmission(_ request: Main.DataTransmission.Request)
    func requestError(_ request: Main.Error.Request)
}

// MARK: - WorkerLogic
protocol MainNetworkWorkerLogic: AnyObject {
    func loadArticles(completion: @escaping ((Result<MainDTO.Response, HTTPError>) -> Void))
    func loadImages(with articles: [MainDTO.Article],
                    completion: @escaping (Result<[String:Data], HTTPError>) -> Void)
}

protocol MainStorageWorkerLogic: AnyObject {
    func proccessArticles(with articleDTOs: [MainDTO.Article],
                          completion: @escaping (([MainDTO.Article]) -> Void))
    
    func getArticles() -> [MainDTO.Article]
    func saveImages(with imageFiles: [MainDTO.ImageFile])
    func getImage(by path: String) -> UIImage
}

// MARK: - PresentationLogic
protocol MainPresentationLogic: AnyObject {
    func presentInitialData(_ response: Main.Initial.Response)
    func presentDataTransmission(_ response: Main.DataTransmission.Response)
    func presentError(_ response: Main.Error.Response)
}

// MARK: - DisplayLogic
protocol MainDisplayLogic: AnyObject {
    func displayInitialData(_ viewModel: Main.Initial.ViewModel)
    func displayDataTransmission(_ viewModel: Main.DataTransmission.ViewModel)
    func displayError(_ viewModel: Main.Error.ViewModel)
}

// MARK: - RoutingLogic
protocol MainRoutingLogic: AnyObject {
    func routeToDetail()
}

// MARK: - DataStore
protocol MainDataStore: AnyObject {
    var data: Main.DetatilDataTransmissionModel? { get set }
}

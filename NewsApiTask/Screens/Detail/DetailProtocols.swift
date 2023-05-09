//
//  DetailProtocols.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 9.05.23.
//

import UIKit

// MARK: - BusinessLogic
protocol DetailBusinessLogic: AnyObject {
    func requestInitialData(_ request: Detail.Initial.Request)
    func requestError(_ request: Detail.Error.Request)
}

protocol DetailStorageWorkerLogic: AnyObject {
    func getArticleObject(by primaryKey: String) -> ArticleManagedObject?
    func getArticle(by primaryKey: String) -> DetailDTO.Article?
    func getImage(by path: String) -> UIImage
}

// MARK: - PresentationLogic
protocol DetailPresentationLogic: AnyObject {
    func presentInitialData(_ response: Detail.Initial.Response)
    func presentError(_ response: Detail.Error.Response)
}

// MARK: - DisplayLogic
protocol DetailDisplayLogic: AnyObject {
    func displayInitialData(_ viewModel: Detail.Initial.ViewModel)
    func displayError(_ viewModel: Detail.Error.ViewModel)
}

// MARK: - RoutingLogic
protocol DetailRoutingLogic: AnyObject {
    func routeToBack()
    func routeToBrowser(url: URL)
}

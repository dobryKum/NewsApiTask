//
//  MainPresenter.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import Foundation

final class MainPresenter {
    // MARK: - Nested Types
    private enum Constants {
        static let errorTitle: String = "Error!"
        static let errorSubtitle: String = "Sorry, we're working on it. Try later."
        static let buttonText: String = "Retry"
    }
    
    // MARK: - Properties
    weak var viewController: MainDisplayLogic?
}

// MARK: - MainPresentationLogic
extension MainPresenter: MainPresentationLogic {
    func presentInitialData(_ response: Main.Initial.Response) {
        let articles: [Main.Initial.ViewModel.Article] = response.articles.map { article in
            Main.Initial.ViewModel.Article(
                title: article.title,
                image: article.image
            )
        }
        let viewModel = Main.Initial.ViewModel(articles: articles)
        viewController?.displayInitialData(viewModel)
    }
    
    func presentDataTransmission(_ response: Main.DataTransmission.Response) {
        viewController?.displayDataTransmission(Main.DataTransmission.ViewModel())
    }
    
    func presentError(_ response: Main.Error.Response) {
        let viewModel = Main.Error.ViewModel(
            title: Constants.errorTitle,
            subtitle: Constants.errorSubtitle,
            buttonText: Constants.buttonText
        )
        viewController?.displayError(viewModel)
    }
}

//
//  DetailPresenter.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 9.05.23.
//

import Foundation

final class DetailPresenter {
    // MARK: - Nested Types
    private enum Constants {
        static let errorTitle: String = "Error!"
        static let errorSubtitle: String = "Sorry, we're working on it. Try later."
        static let buttonText: String = "Ok"
    }
    
    // MARK: - Properties
    weak var viewController: DetailDisplayLogic?
}

// MARK: - DetailPresentationLogic
extension DetailPresenter: DetailPresentationLogic {
    func presentInitialData(_ response: Detail.Initial.Response) {
        let viewModel = Detail.Initial.ViewModel(
            title: response.title,
            subtitle: response.subtitle,
            image: response.image,
            url: response.url
        )
        viewController?.displayInitialData(viewModel)
    }
    
    func presentError(_ response: Detail.Error.Response) {
        let viewModel = Detail.Error.ViewModel(
            title: Constants.errorTitle,
            subtitle: Constants.errorSubtitle,
            buttonText: Constants.buttonText
        )
        viewController?.displayError(viewModel)
    }
}

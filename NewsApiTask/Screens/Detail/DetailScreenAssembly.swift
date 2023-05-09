//
//  DetailScreenAssembly.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import UIKit

enum DetailScreenAssembly {
    static func assemble(data: Main.DetatilDataTransmissionModel) -> UIViewController {
        let presenter = DetailPresenter()
        let storageWorker = DetailStorageWorker()
        
        let interactor = DetailInteractor(
            presenter: presenter,
            storageWorker: storageWorker,
            data: data
        )
        
        let viewModel = DetailViewModel()
        let router = DetailRouter()
        let viewController = DetailViewController(rootView: DetailView(viewModel: viewModel),
                                                  interactor: interactor,
                                                  router: router)

        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
}

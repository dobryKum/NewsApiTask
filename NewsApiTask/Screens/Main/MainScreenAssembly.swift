//
//  MainScreenAssembly.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import UIKit

enum MainScreenAssembly {
    static func assemble() -> UIViewController {
        let presenter = MainPresenter()
        let networkWorker = MainNetworkWorker()
        let storageWorker = MainStorageWorker()
        
        let interactor = MainInteractor(
            presenter: presenter,
            networkWorker: networkWorker,
            storageWorker: storageWorker
        )
        
        let router = MainRouter(dataStore: interactor)
        let viewController = MainViewController(interactor: interactor, router: router)
       
        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
}

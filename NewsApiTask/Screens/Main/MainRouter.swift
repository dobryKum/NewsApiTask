//
//  MainRouter.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import UIKit

final class MainRouter: MainRoutingLogic {
    // MARK: - Properties
    weak var viewController: UIViewController?
    private let dataStore: MainDataStore?
    
    // MARK: - Initialization
    init(dataStore: MainDataStore) {
        self.dataStore = dataStore
    }

    // MARK: - MainRoutingLogic
    func routeToDetail() {
        guard
            let dataStore = dataStore,
            let data = dataStore.data
        else { return }
        
        let view = DetailScreenAssembly.assemble(data: data)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}

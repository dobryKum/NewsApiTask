//
//  DetailRouter.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 9.05.23.
//

import UIKit

final class DetailRouter: DetailRoutingLogic {
    // MARK: - Properties
    weak var viewController: UIViewController?

    // MARK: - DetailRoutingLogic
    func routeToBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToBrowser(url: URL) {
        UIApplication.shared.open(url)
    }
}

//
//  Assembly.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//

import UIKit

enum Assembly {
    static func assemble() -> UIViewController {
        let viewController = MainScreenAssembly.assemble()
        return UINavigationController(rootViewController: viewController)
    }
}

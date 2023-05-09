//
//  StorageContainer.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 4.05.23.
//

import Foundation

final class StorageContainer {
    // MARK: - Shared
    static let shared = StorageContainer()
    
    // MARK: - Properties
    let coreDataService: CoreDataService
    let fileService: FileServiceProtocol
    
    // MARK: - Initialization
    private init(
        coreDataService: CoreDataService = CoreDataService(),
        fileService: FileServiceProtocol = FileService()
    ) {
        self.coreDataService = coreDataService
        self.fileService = fileService
    }
}

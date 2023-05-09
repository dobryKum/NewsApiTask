//
//  CoreDataService.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 4.05.23.
//

import Foundation
import CoreData

final class CoreDataService {
    
    // MARK: - Nested Type
    fileprivate enum Constants {
        static let errorEventName: String = "CoreDataServiceError"
    }
    
    // MARK: - Properties

    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsApiTask")

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    private lazy var writeContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return context
    }()
    
    // MARK: - Methods
    
    func create<T: NSManagedObject>() -> T {
        let entityName = String(describing: T.self)
        guard let object = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                               into: writeContext) as? T else {
            preconditionFailure("Cannot create managed object of type \(T.self)")
        }
        return object
    }
    
    func fetchAll<T: NSManagedObject>() -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        do {
            let fetchResult = try writeContext.fetch(fetchRequest)
            return fetchResult
        } catch {
            post(error)
            return []
        }
    }
    
    func fetch<T: NSManagedObject>(with predicate: NSPredicate? = nil,
                                   sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        do {
            let fetchResult = try writeContext.fetch(fetchRequest)
            return fetchResult
        } catch {
            post(error)
            return []
        }
    }
    
    func save() {
        if writeContext.hasChanges {
            do {
                try writeContext.save()
            } catch {
                post(error)
            }
        }
    }
    
    func delete<T: NSManagedObject>(_ object: T) {
        writeContext.delete(object)
    }
}

// MARK: - Error Handling

extension CoreDataService {
    func observeErrors(completion: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: Notification.Name(Constants.errorEventName),
                                               object: nil,
                                               queue: nil) { notification in
            completion(notification.object as? Error)
        }
    }
    
    func stopObservingRealmErrors() {
        NotificationCenter.default.removeObserver(Notification.Name(Constants.errorEventName))
    }
    
    private func post(_ error: Error) {
        NotificationCenter.default.post(name: Notification.Name(Constants.errorEventName), object: error)
    }
}

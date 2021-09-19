//
//  CoreDataPersistentContainer.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 29.08.2021.
//

import Foundation
import CoreData

class Container {

    lazy var mangaContainer: NSPersistentContainer = {
        var modelURL = Bundle(for: type(of: self))
                .url(forResource: "FinalSberProject", withExtension: "momd")

        modelURL?.appendPathComponent("FinalSberProject.mom")
        guard let model = modelURL, let managedObjectModel = NSManagedObjectModel(contentsOf: model)
            else { return mangaContainer }
        let mangaContainer = NSPersistentContainer(name: "LocalManga", managedObjectModel: managedObjectModel)
        mangaContainer.persistentStoreDescriptions.first?.shouldInferMappingModelAutomatically = false
        mangaContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        return mangaContainer
    }()

}

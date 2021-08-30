//
//  CoreDataPersistentContainer.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 29.08.2021.
//

import Foundation
import CoreData

class Container{
    
    let mangaContainer: NSPersistentContainer = {
        let mangaContainer = NSPersistentContainer(name: "FinalSberProject")
        mangaContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        return mangaContainer
    }()
    
}

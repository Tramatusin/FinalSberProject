//
//  CoreDataManager.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 29.08.2021.
//

import Foundation

protocol CoreDataManager {
    func writeObject(manga: NetManga)
    func fetchResult() -> [LocalManga]?
    func clearObjects()
    func containsCurrentMangaInCoreData(manga: NetManga) -> Bool
}

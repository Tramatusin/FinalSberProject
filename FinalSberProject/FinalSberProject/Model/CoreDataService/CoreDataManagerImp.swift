//
//  CoreDataManagerImp.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 29.08.2021.
//

import Foundation
import CoreData

class CoreDataManagerImp: CoreDataManager {

    let mangaContainer = Container().mangaContainer

    func clearObjects() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LocalManga")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        let writeContext = mangaContainer.newBackgroundContext()
        writeContext.performAndWait {
            _ = try? writeContext.execute(deleteRequest)
            try? writeContext.save()
        }
        print("CLEAR")
    }

    func writeObject(manga: NetManga) {
        let writeContext = mangaContainer.newBackgroundContext()

        guard !containsCurrentMangaInCoreData(manga: manga) else { return }

        writeContext.performAndWait {

            let localManga = LocalManga(context: writeContext)
            localManga.name = manga.name
            localManga.chapters = Int16(manga.chapters?.count ?? 0)
            localManga.cover = manga.cover
            localManga.descriptions = manga.description
            localManga.tags = manga.tags?.joined(separator: ", ")
            localManga.raiting = manga.ratingValue
            localManga.ratingCount = manga.ratingCount
            localManga.code = manga.code
            try? writeContext.save()
        }
    }

    func fetchResult() -> [LocalManga]? {
        let viewContext = mangaContainer.newBackgroundContext()
        var resLocalManga: [LocalManga]? = []

        viewContext.performAndWait {
            guard let localMangas = try? (NSFetchRequest<LocalManga>(entityName: "LocalManga")).execute() else {
                resLocalManga = nil
                return
            }
            resLocalManga = localMangas
        }
        return resLocalManga
    }

    func containsCurrentMangaInCoreData(manga: NetManga) -> Bool {
        let viewContext = mangaContainer.newBackgroundContext()
        var flag = false

        viewContext.performAndWait {
            guard let res = try? (NSFetchRequest<LocalManga>(entityName: "LocalManga")).execute() else { return }
            for item in res where item.name == manga.name {
                flag = true
            }
        }
        return flag
    }

    func castLocalMangaToNetManga() -> [NetManga] {
        var resultMangaList: [NetManga] = []
        let viewContext = mangaContainer.newBackgroundContext()

        viewContext.performAndWait {
            guard let mangas = try? (NSFetchRequest<LocalManga>(entityName: "LocalManga")).execute() else { return }
            for item in mangas {
                guard let name = item.name,
                      let code = item.code,
                      let description = item.descriptions,
                      let tags = item.tags,
                      let cover = item.cover,
                      let raiting = item.raiting,
                      let ratingCount = item.ratingCount
                else { return }
                let netManga = NetManga(name: name, code: code,
                                        description: description, tags: [tags],
                                        cover: cover, raiting: raiting,
                                        chapterCount: Int(item.chapters), ratCont: ratingCount)
                resultMangaList.append(netManga)
            }
        }
        return resultMangaList
    }
    
}

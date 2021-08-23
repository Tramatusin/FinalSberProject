//
//  ParseJSON.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 20.08.2021.
//

import Foundation

class JSONParser{
    
    func deserializeMangaData(jsonData: Data,completion: @escaping (Result<([Manga],[String]),NetworkErrors>)->()){
        let jsonDecoder = JSONDecoder()
        DispatchQueue.global(qos: .userInteractive).async {
            guard
                let mangasList = try? jsonDecoder.decode(Mangas.self, from: jsonData),
                let mangas = mangasList.mangas,
                let codes = mangasList.codes
            else {
                completion(.failure(.warningWithParseJson(message: "Ошибка")))
                return
            }
            for i in 0..<codes.count{
                guard let resTag = mangas[i].tags
                else {
                    completion(.failure(.warningWithParseJson(message: "Ошибка")))
                    return
                }
                let startIn = resTag.startIndex
                let res = Array(resTag[startIn..<resTag.index(startIn, offsetBy: 3)])
                mangas[i].tags = res
                mangas[i].cover?.removeFirst()
                mangas[i].cover?.removeFirst()
                mangas[i].cover?.removeLast()
            }
            completion(.success((mangas,codes)))
        }
    }
    
    func deserealizePagesData(json: Data, completion: @escaping (Result<[Data],NetworkErrors>)->()){
        let pagesDispatchGroup = DispatchGroup()
        var pagesData:[Data] = []
        
        guard let json = try? JSONSerialization.jsonObject(with: json) as? [String: Any],
              let pages = json["pages"] as? [String]
              else {
            print("rerun")
            return
        }
        print(pages)
        for url in pages{
            pagesDispatchGroup.enter()
            guard let resUrl = URL(string: url),
                  let currentPage = try? Data(contentsOf: resUrl) else { return }
            print("page")
            pagesData.append(currentPage)
            pagesDispatchGroup.leave()
        }
        
        pagesDispatchGroup.notify(queue: .global()) {
            completion(.success(pagesData))
        }
    }
    
}

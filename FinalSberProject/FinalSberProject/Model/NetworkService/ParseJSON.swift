//
//  ParseJSON.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 20.08.2021.
//

import Foundation

class JSONParser{
    
    func deserializeMangaData(jsonData: Data)->[Manga]{
        let jsonDecoder = JSONDecoder()
        guard
            let mangasList = try? jsonDecoder.decode(Mangas.self, from: jsonData),
            var mangas = mangasList.mangas,
            let codes = mangasList.codes else {return []}
        for i in 0..<codes.count{
            guard let resTag = mangas[i].tags else {return []}
            let startIn = resTag.startIndex
            let res = Array(resTag[startIn..<resTag.index(startIn, offsetBy: 3)])
            mangas[i].tags = res
            mangas[i].code = codes[i]
            mangas[i].cover?.removeFirst()
            mangas[i].cover?.removeFirst()
            mangas[i].cover?.removeLast()
        }
        return mangas
    }
    
}

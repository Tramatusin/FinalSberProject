//
//  JsonDataService.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 17.09.2021.
//

import Foundation

protocol JsonDataManager {
    func deserializeMangaData(url: URL,
                              completion: @escaping (Result<[NetManga], NetworkErrors>) -> Void)
    func deserealizePagesData(code: String, chapterManga: Chapters,
                              url: URL, completion: @escaping (Result<[Data], NetworkErrors>) -> Void)
}

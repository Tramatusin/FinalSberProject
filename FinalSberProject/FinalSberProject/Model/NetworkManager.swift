//
//  NetworkManager.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import Foundation

protocol NetworkManager {
    func getMangaList(url: URL,completion: @escaping (Result<[Manga],Error>)->())
}

protocol JsonBuilderManager {
    func buildJSONForMangaPages(code: String, volume: Int, chapter: Double, page: Int)->Data
}


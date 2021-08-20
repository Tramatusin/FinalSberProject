//
//  NetworkManager.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import Foundation

protocol NetworkManager {
    func getMangaList(url: URL,completion: @escaping ([Any])->())
}

protocol JsonBuilderManager {
    func buildJSONForMangaList(completion: @escaping ([Any])->())
    func buildJSONForMangaPages(completion: @escaping ([Any])->())
}

//
//  NetworkManager.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import Foundation

protocol NetworkManagerProtocol {
    func getMangaList(url: URL,completion: @escaping (Result<[Manga],NetworkErrors>)->())
    
    func getPagesList(code: String,chapterManga: Chapters,url: URL, completion: @escaping (Result<[Data],NetworkErrors>)->())
}

//protocol <#name#> {
//    <#requirements#>
//}


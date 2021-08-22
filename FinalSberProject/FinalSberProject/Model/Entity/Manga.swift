//
//  Manga.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import Foundation

struct Mangas: Decodable {
    var codes: [String]?
    
    var mangas: [Manga]?
}

class Manga: Decodable{
    
    var code: String?
    
    var name: String?
    
    var description: String?
    
    var tags: [String]?
    
    var cover: String?
    
    var rating_value: String?
    
    var rating_count: String?
    
    var chapters: [Chapters]?
}

struct Chapters: Decodable {
    var volume: Int?
    var chapter: Double?
    var name: String?
}

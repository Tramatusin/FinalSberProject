//
//  Manga.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import Foundation

struct Mangas: Decodable {
    var codes: [String]?
    
    var mangas: [NetManga]?
}

class NetManga: Decodable{
    
    var code: String?
    
    var name: String?
    
    var description: String?
    
    var tags: [String]?
    
    var cover: String?
    
    var rating_value: String?
    
    var rating_count: String?
    
    var chapters: [Chapters]? = []
    
    var countChapter: Int?
    
    init(name: String,code: String, description: String, tags: [String], cover: String, raiting: String, chapterCount: Int) {
        self.name = name
        self.code = code
        self.description = description
        self.tags = tags
        self.cover = cover
        self.rating_value = raiting
        self.countChapter = chapterCount
    }
}

struct Chapters: Decodable {
    public var volume: Int?
    var chapter: Double?
    var name: String?
}

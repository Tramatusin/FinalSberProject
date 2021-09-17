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

class NetManga: Decodable {

    var code: String?

    var name: String?

    var description: String?

    var tags: [String]?

    var cover: String?

    var ratingValue: String?

    var ratingCount: String?

    var chapters: [Chapters]? = []

    var countChapter: Int?

    init(name: String, code: String, description: String,
         tags: [String], cover: String, raiting: String, chapterCount: Int, ratCont: String) {
        self.name = name
        self.code = code
        self.description = description
        self.tags = tags
        self.cover = cover
        self.ratingValue = raiting
        self.countChapter = chapterCount
        self.ratingCount = ratCont
    }

    private func sliceTagsForCell(tags: [String]) -> [String] {
        let startIn = tags.startIndex
        let res = Array(tags[startIn..<tags.index(startIn, offsetBy: 3)])
        return res
    }

    private func cropBase64StringForImage(base64String: String) -> String {
        var resultCover = base64String
        resultCover.removeFirst()
        resultCover.removeFirst()
        resultCover.removeLast()
        return resultCover
    }

    func setupTagsAndCropBase64String() {
        guard let tags = tags, let cover = cover else { return }
        self.tags = sliceTagsForCell(tags: tags)
        self.cover = cropBase64StringForImage(base64String: cover)
    }
}

struct Chapters: Decodable {
    public var volume: Int?
    var chapter: Double?
    var name: String?
}

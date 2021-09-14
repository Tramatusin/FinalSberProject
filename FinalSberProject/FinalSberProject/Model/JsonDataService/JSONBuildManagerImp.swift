//
//  JSONBuildManager.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import Foundation

class JSONBuildManagerImp: JsonBuilderManager {
    func buildJSONForMangaBucket(bucketNum: Int) -> Data? {
        let json: [String: Any] =
            ["batch_num": bucketNum]

        if JSONSerialization.isValidJSONObject(json), bucketNum < 4 {
            guard let jsonResData = try? JSONSerialization.data(withJSONObject: json) else { return nil }
            return jsonResData
        }
        return nil
    }

    func buildJSONForMangaPages(code: String, volume: Int, chapter: Double, page: Int) -> Data? {
        let json: [String: Any] =
            ["code": code,
             "volume": volume,
             "chapter": chapter,
             "page": 1 ]

        if JSONSerialization.isValidJSONObject(json), !code.isEmpty, volume != 0, chapter != 0 {
            guard let jsonResData = try? JSONSerialization.data(withJSONObject: json) else { return nil }
            return jsonResData
        }
        return nil
    }
}

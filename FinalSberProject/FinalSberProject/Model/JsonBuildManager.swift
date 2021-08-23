//
//  JsonBuildManager.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 23.08.2021.
//

import Foundation

protocol JsonBuilderManager {
    func buildJSONForMangaPages(code: String, volume: Int, chapter: Double, page: Int)->Data?
    func buildJSONForMangaBucket(bucketNum: Int)->Data?
}

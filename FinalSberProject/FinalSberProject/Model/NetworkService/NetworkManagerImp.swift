//
//  NetworkManagerImp.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import Foundation

class NetworkManagerImp: NetworkManager {
    private let buildJson: JsonBuilderManager
    private let session: Networking

    init(session: Networking, jsonBuilder: JsonBuilderManager) {
        self.session = session
        self.buildJson = jsonBuilder
    }

    // Метод получающий JSON из манг
    func getMangaList(url: URL, bucket: Int, completion: @escaping (Result<Data, NetworkErrors>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 7
        guard let postData = buildJson.buildJSONForMangaBucket(bucketNum: bucket) else { return }
        request.httpBody = postData

        session.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(.failure(.warningRequest(message: "error with load")))
                return
            }
            guard let dataJson = data else {
                completion(.failure(.warningWithParseJson(message: "pip")))
                return
            }
            completion(.success(dataJson))
        }.resume()
    }

    // Метод получающий JSON из страниц
    func getPagesList(code: String, chapterManga: Chapters,
                      url: URL, completion: @escaping (Result<Data, NetworkErrors>) -> Void) {
        guard let volume = chapterManga.volume,
              let chapter = chapterManga.chapter else { return }
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = buildJson.buildJSONForMangaPages(code: code, volume: volume, chapter: chapter, page: 1)
        request.timeoutInterval = 30

        session.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(.failure(.warningRequest(message: "error with load")))
                return
            }

            guard let data = data else {
                completion(.failure(.warningWithParseJson(message: "pip")))
                return
            }

            completion(.success(data))
        }.resume()
    }

}

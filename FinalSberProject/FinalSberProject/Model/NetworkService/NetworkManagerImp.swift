//
//  NetworkManagerImp.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import Foundation

class NetworkManagerImp: NetworkManager {
    private let buildJson = JSONBuildManagerImp()
    private let session: Networking
//    let parseJson = JSONParser()

    init(session: Networking) {
        self.session = session
    }

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

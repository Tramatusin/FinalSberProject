//
//  ParseJSON.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 20.08.2021.
//

import Foundation

class JSONParser {
    private let networkManager: NetworkManager

    init(session: Networking) {
        self.networkManager = NetworkManagerImp(session: session)
    }

    func deserializeMangaData(url: URL,
                              completion: @escaping (Result<[NetManga], NetworkErrors>) -> Void) {
        var resultMangaList: [NetManga] = []
        let mangaLoadGroup = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 1)
        for bucket in 1...3 {
            semaphore.wait()
            mangaLoadGroup.enter()
            self.networkManager.getMangaList(url: url, bucket: bucket) { [weak self] result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    guard let currentMangas = self?.deserializeDataToNetmanga(jsonData: data)
                    else { return }
                    resultMangaList += currentMangas
                    print("kiki")
                    mangaLoadGroup.leave()
                    semaphore.signal()
                }
            }
        }
        mangaLoadGroup.notify(queue: .global()) {
            completion(.success(resultMangaList))
        }
    }

    func deserealizePagesData(code: String, chapterManga: Chapters,
                              url: URL, completion: @escaping (Result<[Data], NetworkErrors>) -> Void) {
        var pagesData: [Data] = []

        networkManager.getPagesList(code: code, chapterManga: chapterManga, url: url) {
            [weak self] result in
            switch result {
            case .failure(let error):
                completion(.failure(.warningRequest(message: error.localizedDescription)))
            case .success(let urlsPages):
                guard let pages = self?.deserializeDataToURLsArray(jsonData: urlsPages),
                      !pages.isEmpty
                else {
                    completion(.failure(.warningWithParseJson(message: "Array with pages is Empty")))
                    return
                }

                print(pages)
                let group = DispatchGroup()
                let semaphore = DispatchSemaphore(value: 1)
                for url in pages {
                    semaphore.wait()
                    group.enter()
                    DispatchQueue.global(qos: .userInteractive).async {
                        guard let resUrl = URL(string: url),
                              let currentPage = try? Data(contentsOf: resUrl) else {
                            completion(.success(pagesData))
                            return }
                        print("page")
                        pagesData.append(currentPage)
                        group.leave()
                        semaphore.signal()
                    }
                }
                group.notify(queue: .global()) {
                    completion(.success(pagesData))
                }
            }
        }
    }

    func deserializeDataToURLsArray(jsonData: Data) -> [String] {
        guard let json = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
              let pages = json["pages"] as? [String]
        else {
            print("rerun")
            return []
        }
        return pages
    }

    func deserializeDataToNetmanga(jsonData: Data) -> [NetManga] {
        let jsonDecoder = JSONDecoder()
        guard
            let mangasList = try? jsonDecoder.decode(Mangas.self, from: jsonData),
            let mangas = mangasList.mangas,
            let codes = mangasList.codes,
            let resultRatingsData = getRatingsAndRatingCount(jsonData: jsonData)
        else { return [] }
        for (index, manga) in mangas.enumerated() {
            manga.setupTagsAndCropBase64String()
            manga.code = codes[index]
            manga.ratingValue = resultRatingsData.ratings[index]
            manga.ratingCount = resultRatingsData.ratingsCount[index]
        }
        return mangas
    }

    func getRatingsAndRatingCount(jsonData: Data) -> (ratings: [String], ratingsCount: [String])? {
        guard let jsonForRating = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
              let jsonMangas = jsonForRating["mangas"] as? [Any] else { return nil }
        var resultRatingArray: [String] = []
        var resultCountArray: [String] = []
        for json in jsonMangas {
            if let json = json as? [String: Any],
               let rating = json["rating_value"] as? String, let count = json["rating_count"] as? String {
                resultRatingArray.append(rating)
                resultCountArray.append(count)
            }
        }
        return (resultRatingArray, resultCountArray)
    }
}

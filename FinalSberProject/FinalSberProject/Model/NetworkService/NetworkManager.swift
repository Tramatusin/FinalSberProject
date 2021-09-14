//
//  NetworkManager.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import Foundation

protocol NetworkManager {
    func getMangaList(url: URL, bucket: Int, completion: @escaping (Result<Data, NetworkErrors>) -> Void)

    func getPagesList(code: String, chapterManga: Chapters, url: URL,
                      completion: @escaping (Result<Data, NetworkErrors>) -> Void)
}

// For tests
protocol Networking {
    func dataTask(with request: URLRequest,
    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: Networking {}

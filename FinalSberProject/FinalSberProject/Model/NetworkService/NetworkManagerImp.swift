//
//  NetworkManagerImp.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import Foundation

class NetworkManagerImp: NetworkManager{
    let parseJson = JSONParser()
    let buildJson = JSONBuildManagerImp()
    
    func getMangaList(url: URL,completion: @escaping (Result<[Manga],NetworkErrors>) -> ()) {
        var request = URLRequest(url: url)
        let mangaGetGroup = DispatchGroup()
        var mangaList: [Manga] = []
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        for bucket in 1...3{
            mangaGetGroup.enter()
            guard let postData = buildJson.buildJSONForMangaBucket(bucketNum: bucket) else {return}
            request.httpBody = postData
            URLSession.shared.dataTask(with: request) { [weak self] data, urlResp, error in
                guard error == nil else {
                    return
                }
                
                guard let dataForJson = data else {return}
                print(bucket)
                self?.parseJson.deserializeMangaData(jsonData: dataForJson, completion: { result in
                    switch result{
                    case .failure(let error):
                        print(error)
                    case .success(let manga):
                        mangaList += manga
                    }
                })
                
                mangaGetGroup.leave()
            }.resume()
        }
        
        mangaGetGroup.notify(queue: .global()) {
            completion(.success(mangaList))
        }
    }
    
    func getPagesList(code: String,chapterManga: Chapters,url: URL, completion: @escaping (Result<[Data], NetworkErrors>) -> ()) {
        guard let volume = chapterManga.volume,
              let chapter = chapterManga.chapter else { return }
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = buildJson.buildJSONForMangaPages(code: code, volume: volume, chapter: chapter, page: 1)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil else { return }
            
            guard let data = data else { return }
            
            self?.parseJson.deserealizePagesData(json: data) { result in
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let pages):
                    completion(.success(pages))
                }
            }
        }.resume()
    }
    
}

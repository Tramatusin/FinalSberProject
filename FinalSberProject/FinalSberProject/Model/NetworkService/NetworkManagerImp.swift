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
    
    func getMangaList(url: URL,completion: @escaping (Result<[Manga],Error>) -> ()) {
        var request = URLRequest(url: url)
        let mangaGetGroup = DispatchGroup()
        var mangaList: [Manga] = []
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        for bucket in 1...10{
            mangaGetGroup.enter()
            guard let postData = try? JSONSerialization.data(withJSONObject: ["batch_num" : bucket], options: []) else {return}
            request.httpBody = postData
            URLSession.shared.dataTask(with: request) { [weak self] data, urlResp, error in
                guard error == nil else {
                    //completion(.failure(error!))
                    return
                }
                
                guard let dataForJson = data else {return}
                print(bucket)
                guard let mangas = self?.parseJson.deserializeMangaData(jsonData: dataForJson) else {return}
                
                mangaList += mangas
                
                mangaGetGroup.leave()
            }.resume()
        }
        
        mangaGetGroup.notify(queue: .global()) {
            completion(.success(mangaList))
        }
    }
    
}

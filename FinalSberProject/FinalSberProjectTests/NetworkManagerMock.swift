//
//  NetworkManagerMock.swift
//  FinalSberProjectTests
//
//  Created by Виктор Поволоцкий on 07.09.2021.
//

import Foundation
@testable import FinalSberProject

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}

class NetworkingMock: Networking {
    var result: Result<Data?, Error>?

    var completion: ((Data?, URLResponse?, Error?) -> Void)?

    var request: URLRequest?

    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = request
        self.completion = completionHandler

        switch result {
        case .success(let data):
            return URLSessionDataTaskMock { completionHandler(data, nil, nil) }
        case .failure(let error):
            return URLSessionDataTaskMock { completionHandler(nil, nil, error) }
        case .none:
            return URLSession.shared.dataTask(with: URL(string: "https://mangalib.me/")!) { _, _, _ in }
        }
    }

    func callCompletion() {
        guard let result = result else { return }
        switch result {
        case .failure(let error):
            completion?(nil, nil, error)
            completion = nil
        case .success(let data):
            completion?(data, nil, nil)
            completion = nil
        }
    }
}

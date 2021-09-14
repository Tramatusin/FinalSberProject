//
//  FinalSberProjectTests.swift
//  FinalSberProjectTests
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import XCTest
@testable import FinalSberProject

class FinalSberProjectTests: XCTestCase {

    // MARK: - Tests for JsonBuilder for Bucket of Manga

    let jsonBuilder = JSONBuildManagerImp()
    let jsonDecoder = JSONSerialization.self

    func testJsonBuilderForMangaBucketShouldReturnCorrectResult() throws {
        // arrange
        let isValidExample = ["batch_num": 2]

        // act
        guard let data = jsonBuilder.buildJSONForMangaBucket(bucketNum: 2),
              let res = try? jsonDecoder.jsonObject(with: data, options: []) as? [String: Int]
        else { return }

        // assert
        XCTAssertEqual(res, isValidExample)
    }

    func testJsonBuilderForMangaBucketShouldReturnIncorrectResult() throws {
        // arrange
        let isValidExample = ["batch_num": 1]

        // act
        guard let data = jsonBuilder.buildJSONForMangaBucket(bucketNum: 2),
              let res = try? jsonDecoder.jsonObject(with: data, options: []) as? [String: Int]
        else { return }

        // assert
        XCTAssertNotEqual(res, isValidExample)
    }

    func testJsonBuilderForMangaBucketShouldReturnNilResult() throws {

        // act
        let data = jsonBuilder.buildJSONForMangaBucket(bucketNum: 5)

        // assert
        XCTAssertNil(data)
    }

    func testJsonBuilderForMangaBucketShouldReturnNotNilResult() throws {

        // act
        guard let data = jsonBuilder.buildJSONForMangaBucket(bucketNum: 3),
              let res = try? jsonDecoder.jsonObject(with: data, options: []) as? [String: Int]
        else { return }

        // assert
        XCTAssertNotNil(res)
    }

    // MARK: - Tests for JsonBuilder for pages of current Manga

    func testJsonBuilderForMangaPagesShouldReturnNotNilResult() throws {

        // act
        guard let data = jsonBuilder.buildJSONForMangaPages(code: "soloLeveling", volume: 1, chapter: 2, page: 1),
              let res = try? jsonDecoder.jsonObject(with: data, options: []) as? [String: Any]
        else { return }

        // assert
        XCTAssertNotNil(res)
    }

    func testJsonBuilderForMangaPagesShouldReturnNilResult() throws {
        // arrange
        // act
        let data = jsonBuilder.buildJSONForMangaPages(code: "", volume: 0, chapter: 0, page: 1)

        // assert
        XCTAssertNil(data)
    }

    // MARK: - Tests for NetworkManager
    let session = NetworkingMock()

    func testGetMangaListShouldReturnCorrectData() throws {
        // arrange
        let manager = NetworkManagerImp(session: session)
        let data = Data()
        session.result = .success(data)
        let url = URL(string: "url")!
        var resultData: Result<Data, NetworkErrors>?

        // act
        manager.getMangaList(url: url, bucket: 1) { result in
            resultData = result
            switch result {
            case .success:
                print("correct data")
            case .failure:
                XCTFail("incorrect work")
            }
        }
        session.callCompletion()

        // assert
        XCTAssertEqual(resultData, .success(data))
        XCTAssertEqual(session.request?.url?.absoluteString, "url")
    }

    func testGetMangaListSouldReturnErrorWarningRequest() throws {
        // arrange
        let networkManager = NetworkManagerImp(session: session)
        session.result = .failure(NetworkErrors.warningRequest(message: "Error with request"))
        var receivedError: NetworkErrors?

        // act
        networkManager.getMangaList(url: URL(string: "manga")!, bucket: 2) { result in
            switch result {
            case .failure(let error):
                receivedError = error
            case .success:
                break
            }
        }
        session.callCompletion()

        // assert
        XCTAssertNotNil(receivedError)
    }

    func testGetMangaListShouldWarningWithJsonParse() throws {
        // arrange
        let networkManager = NetworkManagerImp(session: session)
        session.result = .success(nil)
        var receivedError: NetworkErrors?

        // act
        networkManager.getMangaList(url: URL(string: "manga")!, bucket: 2) { result in
            switch result {
            case .failure(let error):
                receivedError = error
            case .success:
                break
            }
        }
        session.callCompletion()

        // assert
        XCTAssertNotNil(receivedError)
    }

    func testGetPagesListShouldReturnCorrectData()throws {
        // arrange
        let manager = NetworkManagerImp(session: session)
        let data = Data()
        session.result = .success(data)
        let url = URL(string: "url")!
        let chapter = Chapters(volume: 1, chapter: 2, name: "")

        // act
        var resultData: Result<Data, NetworkErrors>?
        manager.getPagesList(code: "solo", chapterManga: chapter, url: url) { result in
            resultData = result
            switch result {
            case .failure:
                XCTFail("incorrect work")
            case .success:
                print("correct work")
            }
        }
        session.callCompletion()

        // assert
        XCTAssertEqual(resultData, .success(data))
    }

    func testGetPagesListSouldReturnErrorWarningRequest() throws {
        // arrange
        let networkManager = NetworkManagerImp(session: session)
        session.result = .failure(NetworkErrors.warningRequest(message: "Error with request"))
        var receivedError: NetworkErrors?
        let url = URL(string: "url")!
        let chapter = Chapters(volume: 1, chapter: 2, name: "")

        // act
        networkManager.getPagesList(code: "solo", chapterManga: chapter, url: url) { result in
            switch result {
            case .failure(let error):
                receivedError = error
            case .success:
                break
            }
        }
        session.callCompletion()

        // assert
        XCTAssertNotNil(receivedError)
    }

    func testGetPagesListShouldWarningWithJsonParse() throws {
        // arrange
        let networkManager = NetworkManagerImp(session: session)
        session.result = .success(nil)
        var receivedError: NetworkErrors?
        let url = URL(string: "url")!
        let chapter = Chapters(volume: 1, chapter: 2, name: "")

        // act
        networkManager.getPagesList(code: "solo", chapterManga: chapter, url: url) { result in
            switch result {
            case .failure(let error):
                receivedError = error
            case .success:
                break
            }
        }
        session.callCompletion()

        // assert
        XCTAssertNotNil(receivedError)
    }

    func testDeserializeMangas() throws {
        // arrange
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "manga", ofType: "txt")!
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }
        let parser = JSONParser(session: URLSession.shared)

        // act
        let result = parser.deserializeDataToNetmanga(jsonData: data)

        // assert
        XCTAssertNotNil(result)
    }

    func testNetMangaSetupMethod() throws {
        // arrange
        let netManga = NetManga(name: "solo", code: "sololevelup", description: "hello",
                                tags: ["мистика", "фэнтези", "артефакты", "система"],
                                cover: "22фоточка2", raiting: "", chapterCount: 2)

        // act
        netManga.setupTagsAndCropBase64String()

        // assert
        XCTAssertEqual(netManga.cover, "фоточка")
        XCTAssertEqual(netManga.tags, ["мистика", "фэнтези", "артефакты"])
    }

    func testDeserealizePages() throws {
        // arrange
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "pages", ofType: "txt")!
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }
        let parser = JSONParser(session: URLSession.shared)

        // act
        let result = parser.deserializeDataToURLsArray(jsonData: data)

        // assert
        XCTAssertNotNil(result)
    }

    // MARK: - Tests for JSONParser

    func testDeserializeMangaShouldReturnEmptyArray() throws {
        // arrange
        let data = Data()
        let parser = JSONParser(session: session)

        // act
        let result = parser.deserializeDataToNetmanga(jsonData: data)

        // assert
        XCTAssertEqual(result.isEmpty, true)
    }

    func testDeserializePagesShouldReturnEmptyArray() throws {
        // arrange
        let data = Data()
        let parser = JSONParser(session: session)

        // act
        let result = parser.deserializeDataToURLsArray(jsonData: data)

        // assert
        XCTAssertEqual(result.isEmpty, true)
    }

    func testLoadAndDeserializePagesShouldReturnCorrectResult() throws {
        // arrange
        let dataManager = JSONParser(session: session)
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "pages", ofType: "txt")!
        let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        session.result = .success(data)
        let url = URL(string: "url")!
        let chapter = Chapters(volume: 1, chapter: 2, name: "")

        // act
        var resultData: Result<[Data], NetworkErrors>?
        dataManager.deserealizePagesData(code: "code", chapterManga: chapter, url: url) { result in
            resultData = result
            switch result {
            case .failure:
                XCTFail("incorrect work")
            case .success:
                print("correct work")
            }
        }

        // assert
        XCTAssertNotNil(resultData)
    }

}

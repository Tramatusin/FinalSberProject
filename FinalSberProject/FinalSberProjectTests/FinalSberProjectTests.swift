//
//  FinalSberProjectTests.swift
//  FinalSberProjectTests
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import XCTest
@testable import FinalSberProject

class FinalSberProjectTests: XCTestCase {
    
    //MARK: - Tests for JsonBuilder for Bucket of Manga
    
    func testJsonBuilderForMangaBucketShouldReturnCorrectResult() throws{
        let jsonBuilder = JSONBuildManagerImp()
        let jsonDecoder = JSONSerialization.self
        let isValidExample = ["batch_num" : 2]
        
        guard let data = jsonBuilder.buildJSONForMangaBucket(bucketNum: 2),
              let res = try? jsonDecoder.jsonObject(with: data, options: []) as? [String : Int]
        else { return }
        
        
        XCTAssertEqual(res, isValidExample)
    }
    
    func testJsonBuilderForMangaBucketShouldReturnIncorrectResult() throws{
        let jsonBuilder = JSONBuildManagerImp()
        let jsonDecoder = JSONSerialization.self
        let isValidExample = ["batch_num" : 1]
        
        guard let data = jsonBuilder.buildJSONForMangaBucket(bucketNum: 2),
              let res = try? jsonDecoder.jsonObject(with: data, options: []) as? [String : Int]
        else { return }
        
        
        XCTAssertNotEqual(res, isValidExample)
    }
    
    func testJsonBuilderForMangaBucketShouldReturnNilResult() throws{
        let jsonBuilder = JSONBuildManagerImp()
        
        let data = jsonBuilder.buildJSONForMangaBucket(bucketNum: 5)
        
        XCTAssertNil(data)
    }
    
    func testJsonBuilderForMangaBucketShouldReturnNotNilResult() throws{
        let jsonBuilder = JSONBuildManagerImp()
        let jsonDecoder = JSONSerialization.self
        
        guard let data = jsonBuilder.buildJSONForMangaBucket(bucketNum: 3),
              let res = try? jsonDecoder.jsonObject(with: data, options: []) as? [String : Int]
        else { return }
        
        XCTAssertNotNil(res)
    }
    
    //MARK: - Tests for JsonBuilder for pages of current Manga
    
    func testJsonBuilderForMangaPagesShouldReturnNotNilResult() throws{
        let jsonBuilder = JSONBuildManagerImp()
        let jsonDecoder = JSONSerialization.self
        
        guard let data = jsonBuilder.buildJSONForMangaPages(code: "soloLeveling", volume: 1, chapter: 2, page: 1),
              let res = try? jsonDecoder.jsonObject(with: data, options: []) as? [String : Any]
        else { return }
        
        XCTAssertNotNil(res)
    }
    
    func testJsonBuilderForMangaPagesShouldReturnNilResult() throws{
        let jsonBuilder = JSONBuildManagerImp()
        
        let data = jsonBuilder.buildJSONForMangaPages(code: "", volume: 0, chapter: 0, page: 1)
        
        XCTAssertNil(data)
    }

}

//
//  APODRequestTest.swift
//  PlanetariumApplicationTests
//
//  Created by Mikael Holm on 18.11.2021.
//

import XCTest
@testable import PlanetariumApplication

class APODRequestTest: XCTestCase {
    var urlSession: URLSession!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }
    
    func testGetPictureInfos() throws {
        let apodRequest = APODRequest(urlSession: urlSession)
        let testData = try FileUtil.readJsonFromFile(fileName: "testAPOD")
        
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), testData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        apodRequest.getPictureInfos(startDate: Date(timeIntervalSinceNow: -60 * 60 * 24 * 30), endDate: Date()) { (result) in
            var firstItem: PictureInfo? = nil
            
            switch result {
            case .success(let pictureInfos):
                firstItem = pictureInfos.first
            case .failure(let error):
                print("There was an error fetching photos: \(error)")
            }
            
            XCTAssertNotNil(firstItem)
            XCTAssertEqual("2021-11-02", firstItem?.date)
            XCTAssertEqual("SN Requiem: A Supernova Seen Three Times So Far", firstItem?.title)
            XCTAssertEqual("image", firstItem?.mediaType)
            XCTAssertEqual("https://apod.nasa.gov/apod/image/2111/MACSJ0138_Hubble_1080.jpg", firstItem?.url)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}

//
//  FavoriteRepositoryTest.swift
//  Tests iOS
//
//  Created by Mikael Holm on 16.11.2021.
//

import XCTest
@testable import PlanetariumApplication

class FavoriteRepositoryTest: XCTestCase {
    private var favoriteRepository: FavoriteRepository!
    
    override func setUp() {
        let persistenceController = PersistenceController(inMemory: true)
        favoriteRepository = FavoriteRepository(context: persistenceController.container.viewContext)
    }
    
    override func tearDown() {
        favoriteRepository = nil
    }
    
    func testFavoritesCanBeAdded() {
        let pictureInfo1 = PictureInfo(copyright: nil, date: "2021-11-15", explanation: "This is an example.", hdUrl: nil, mediaType: "image", thumbnailUrl: nil, title: "Test 1", url: "https://example.com/pictures/1")
        let pictureInfo2 = PictureInfo(copyright: nil, date: "2021-11-16", explanation: "This is the second example.", hdUrl: nil, mediaType: "video", thumbnailUrl: "https://example.com/thumbnails/2", title: "Test 2", url: "https://example.com/videos/2")
        
        favoriteRepository.addFavorite(pictureInfo: pictureInfo1)
        favoriteRepository.addFavorite(pictureInfo: pictureInfo2)
        let favorites = favoriteRepository.getFavorites()
        
        XCTAssertEqual(2, favorites.count)
        
        XCTAssertEqual(true, favorites[0].video)
        XCTAssertEqual("This is the second example.", favorites[0].explanation)
        XCTAssertEqual("Test 2", favorites[0].title)
        XCTAssertEqual("https://example.com/videos/2", favorites[0].url)
        XCTAssertEqual("https://example.com/thumbnails/2", favorites[0].thumbnailUrl)
        XCTAssertEqual("2021-11-16", favorites[0].date)
        
        XCTAssertEqual(false, favorites[1].video)
        XCTAssertEqual("This is an example.", favorites[1].explanation)
        XCTAssertEqual("Test 1", favorites[1].title)
        XCTAssertEqual("https://example.com/pictures/1", favorites[1].url)
        XCTAssertEqual("2021-11-15", favorites[1].date)
    }
    
    func testFavoriteIsFound() {
        let pictureInfo = PictureInfo(copyright: nil, date: "2021-11-18", explanation: "This is an example.", hdUrl: nil, mediaType: "image", thumbnailUrl: nil, title: "Test", url: "https://example.com")
        
        favoriteRepository.addFavorite(pictureInfo: pictureInfo)
        
        XCTAssertTrue(favoriteRepository.favoriteExists(date: "2021-11-18"))
        XCTAssertFalse(favoriteRepository.favoriteExists(date: "2021-11-19"))
    }
    
    func testFavoriteIsDeleted() {
        let pictureInfo1 = PictureInfo(copyright: nil, date: "2021-11-15", explanation: "This is an example.", hdUrl: nil, mediaType: "image", thumbnailUrl: nil, title: "Test 1", url: "https://example.com/pictures/1")
        let pictureInfo2 = PictureInfo(copyright: nil, date: "2021-11-16", explanation: "This is the second example.", hdUrl: nil, mediaType: "video", thumbnailUrl: "https://example.com/thumbnails/2", title: "Test 2", url: "https://example.com/videos/2")
        
        favoriteRepository.addFavorite(pictureInfo: pictureInfo1)
        favoriteRepository.addFavorite(pictureInfo: pictureInfo2)
        var favorites = favoriteRepository.getFavorites()
        favoriteRepository.deleteFavorite(favorite: favorites[0])
        favorites = favoriteRepository.getFavorites()
        
        XCTAssertEqual(1, favorites.count)
        XCTAssertEqual("2021-11-15", favorites[0].date)
        XCTAssertEqual("Test 1", favorites[0].title)
    }
    
    func testFavoriteIsDeletedByDate() {
        let pictureInfo = PictureInfo(copyright: nil, date: "2021-11-18", explanation: "This is an example.", hdUrl: nil, mediaType: "image", thumbnailUrl: nil, title: "Test", url: "https://example.com")
        
        favoriteRepository.addFavorite(pictureInfo: pictureInfo)
        favoriteRepository.deleteFavoriteByDate(date: "2021-11-18")
        let favorites = favoriteRepository.getFavorites()
        
        XCTAssertEqual(0, favorites.count)
    }
}

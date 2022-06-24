//
//  VideoRemoteDataStoreTests.swift
//  DailyMotionTests
//
//  Created by Andrei-Stefan BURSUC on 24.06.2022.
//

import Foundation
import XCTest
@testable import DailyMotion

class VideoRemoteDataStoreTests: XCTestCase {
    func testGetVideo() {
        let videoModelRepresentation = GetVideoRepresentation(page: 1,
                                    limit: 1,
                                    explicit: true,
                                    total: 1,
                                    hasMore: false,
                                    list: [VideoListModelRepresentation(id: "id",
                                                          thumbnail1080Url: "thumbnail1080Url",
                                                          title: "title",
                                                          description: "description" ,
                                                          url: "url",
                                                          createdTime: 123456)])
        let expectation = self.expectation(description: "Get video")

        let dataStore = MockVideoRemoteDataStore {
            return videoModelRepresentation
        }

        dataStore.getVideos { response in
            XCTAssertEqual(response.page, videoModelRepresentation.page)
            XCTAssertEqual(response.limit, videoModelRepresentation.limit)
            XCTAssertEqual(response.explicit, videoModelRepresentation.explicit)
            XCTAssertEqual(response.total, videoModelRepresentation.total)
            XCTAssertEqual(response.hasMore, videoModelRepresentation.hasMore)
            XCTAssertEqual(response.list[0].id, videoModelRepresentation.list[0].id)
            XCTAssertEqual(response.list[0].thumbnail1080Url, videoModelRepresentation.list[0].thumbnail1080Url)
            XCTAssertEqual(response.list[0].title, videoModelRepresentation.list[0].title)
            XCTAssertEqual(response.list[0].description, videoModelRepresentation.list[0].description)
            XCTAssertEqual(response.list[0].url, videoModelRepresentation.list[0].url)
            XCTAssertEqual(response.list[0].createdTime, videoModelRepresentation.list[0].createdTime)

            expectation.fulfill()
        } error: { error in
        }
        wait(for: [expectation], timeout: 1.0)
    }
}

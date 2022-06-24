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
        let videoModel = VideoModel(page: 1,
                                    limit: 1,
                                    explicit: true,
                                    total: 1,
                                    hasMore: false,
                                    list: [VideoListModel(id: "id",
                                                          thumbnail1080Url: "thumbnail1080Url",
                                                          title: "title",
                                                          description: "description" ,
                                                          url: "url",
                                                          createdTime: 123456)])
        let expectation = self.expectation(description: "Get video")

        let dataStore = MockVideoRemoteDataStore {
            return videoModel
        }

        dataStore.getVideos { response in
            XCTAssertEqual(response.page, videoModel.page)
            XCTAssertEqual(response.limit, videoModel.limit)
            XCTAssertEqual(response.explicit, videoModel.explicit)
            XCTAssertEqual(response.total, videoModel.total)
            XCTAssertEqual(response.hasMore, videoModel.hasMore)
            XCTAssertEqual(response.list[0].id, videoModel.list[0].id)
            XCTAssertEqual(response.list[0].thumbnail1080Url, videoModel.list[0].thumbnail1080Url)
            XCTAssertEqual(response.list[0].title, videoModel.list[0].title)
            XCTAssertEqual(response.list[0].description, videoModel.list[0].description)
            XCTAssertEqual(response.list[0].url, videoModel.list[0].url)
            XCTAssertEqual(response.list[0].createdTime, videoModel.list[0].createdTime)

            expectation.fulfill()
        } error: { error in
        }
        wait(for: [expectation], timeout: 1.0)
    }
}

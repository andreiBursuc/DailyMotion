//
//  GetVideoRepresentation.swift
//  DailyMotion
//
//  Created by Andrei-Stefan BURSUC on 24.06.2022.
//

import Foundation

struct GetVideoRepresentation: Codable {
    let page: Int
    let limit: Int
    let explicit: Bool
    let total: Int
    let hasMore: Bool
    let list: [VideoListModelRepresentation]
}

struct VideoListModelRepresentation: Codable {
    let id: String
    let thumbnail1080Url: String
    let title: String
    let description: String
    let url: String
    let createdTime: Int
}

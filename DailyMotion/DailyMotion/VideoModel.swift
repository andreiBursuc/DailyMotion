//
//  VideoModel.swift
//  DailyMotion
//
//  Created by Andrei-Stefan BURSUC on 23.06.2022.
//

struct VideoModel: Codable {
    let page: Int
    let limit: Int
    let explicit: Bool
    let total: Int
    let hasMore: Bool
    let list: [VideoListModel]
}

struct VideoListModel: Codable {
    let id: String
    let thumbnail1080Url: String
    let title: String
    let description: String
    let url: String
    let createdTime: Int
}

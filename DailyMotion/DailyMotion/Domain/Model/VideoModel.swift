//
//  VideoModel.swift
//  DailyMotion
//
//  Created by Andrei-Stefan BURSUC on 23.06.2022.
//

import Foundation

struct Video: Equatable {

    // MARK: - Paramaters

    let thumbnail: URL
    let title: String
    let description: String
    let createdAt: Date
    let url: URL

    // MARK: - Initializers

    init(thumbnail: URL,
         title: String,
         description: String,
         createdAt: Date,
         url: URL) {
        self.thumbnail = thumbnail
        self.title = title
        self.description = description
        self.createdAt = createdAt
        self.url = url
    }
}

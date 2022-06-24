//
//  Endpoint+Video.swift
//  DailyMotion
//
//  Created by Andrei-Stefan BURSUC on 24.06.2022.
//

import Foundation

enum FieldPathComponent: String {
    case id
    case thumbnail1080Url = "thumbnail_1080_url"
    case title
    case description
    case url
    case createdTime = "created_time"
}

enum ChannelPathComponent: String {
    case news
}

extension Endpoint {
    static func videos(channel: ChannelPathComponent, limit: Int, fields: [FieldPathComponent]) -> Endpoint {
        var fieldsString: String = ""
        let lastField = fields.last
        fields.forEach {
            fieldsString.append(contentsOf: $0.rawValue)
            if $0 != lastField {
                fieldsString.append(contentsOf: ",")
            }
        }

        return Endpoint(
            path: "/videos",
            queryItems: [
                URLQueryItem(name: "channel", value: channel.rawValue),
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "fields", value: fieldsString)
            ]
        )
    }
}

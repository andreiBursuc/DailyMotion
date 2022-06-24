//
//  VideoRepository.swift
//  DailyMotion
//
//  Created by Andrei-Stefan BURSUC on 23.06.2022.
//

import Foundation

typealias VideoSuccessCompletionHandler = (_ response: [Video]) -> Void

protocol VideoRepositoryProtocol {
    /// Retrieve the list of videos
    func videos(then success: @escaping VideoSuccessCompletionHandler, error: @escaping ErrorCompletionHandler)
}

class VideoRepository: VideoRepositoryProtocol {

    // MARK: - Parameters

    let videoRemoteDataStore: VideoRemoteDataStoreProtocol

    // MARK: - Initializer

    init(videoRemoteDataStore: VideoRemoteDataStoreProtocol = VideoRemoteDataStore()) {
        self.videoRemoteDataStore = videoRemoteDataStore
    }

    // MARK: - VideoRepositoryProtocol

    func videos(then success: @escaping VideoSuccessCompletionHandler, error: @escaping ErrorCompletionHandler) {
        videoRemoteDataStore.getVideos { [weak self] response in

            let video = self?.handleSuccess(representation: response)
            success(video ?? [])
        } error: { errorResponse in
            error(errorResponse)
        }
    }

    private func handleSuccess(representation: GetVideoRepresentation) -> [Video] {
        var videos: [Video] = []
        for videoRepresentation in representation.list {
            let thumbnailURL = URL(string: videoRepresentation.thumbnail1080Url)
            let title = videoRepresentation.title
            let description = videoRepresentation.description
            let createdAt = Date(timeIntervalSince1970: TimeInterval(videoRepresentation.createdTime))
            let url = URL(string: videoRepresentation.url)

            if let url = url, let thumbnailURL = thumbnailURL {
                videos.append(Video(thumbnail: thumbnailURL,
                                    title: title,
                                    description: description,
                                    createdAt: createdAt,
                                    url: url))
            } else {
                assertionFailure("unable to create the URL")
            }
        }

        return videos
    }
}

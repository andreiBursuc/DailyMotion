//
//  VideoRepository.swift
//  DailyMotion
//
//  Created by Andrei-Stefan BURSUC on 23.06.2022.
//

import Foundation

protocol VdeoRepositoryProtocol {
    /// Retrieve the list of videos
    func videos(then success: @escaping SuccessCompletionHandler, error: @escaping ErrorCompletionHandler)
}

class VideoRepository: VdeoRepositoryProtocol {

    // MARK: - Parameters

    let videoRemoteDataStore: VideoRemoteDataStoreProtocol

    // MARK: - Initializer

    init(videoRemoteDataStore: VideoRemoteDataStoreProtocol = VideoRemoteDataStore()) {
        self.videoRemoteDataStore = videoRemoteDataStore
    }

    // MARK: - VdeoRepositoryProtocol

    func videos(then success: @escaping SuccessCompletionHandler, error: @escaping ErrorCompletionHandler) {
        videoRemoteDataStore.getVideos { response in
            success(response)
        } error: { errorResponse in
            error(errorResponse)
        }
    }
}
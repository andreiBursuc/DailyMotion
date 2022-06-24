//
//  GetVideosUseCase.swift
//  DailyMotion
//
//  Created by Andrei-Stefan BURSUC on 24.06.2022.
//

import Foundation

protocol GetVideosUseCaseProtocol {
    var videoRepository: VideoRepositoryProtocol { get }

    /// Retrieve the list of videos
    func retrieveVideos(then success: @escaping VideoSuccessCompletionHandler, error: @escaping ErrorCompletionHandler)
}

struct GetVideosUseCase: GetVideosUseCaseProtocol {

    // MARK: - Parameters

    let videoRepository: VideoRepositoryProtocol

    // MARK: - Initializer

    init(videoRepository: VideoRepositoryProtocol = VideoRepository()) {
        self.videoRepository = videoRepository
    }

    // MARK: - GetVideosUseCaseProtocol

    func retrieveVideos(then success: @escaping VideoSuccessCompletionHandler, error: @escaping ErrorCompletionHandler) {
        videoRepository.videos(then: success, error: error)
    }
}

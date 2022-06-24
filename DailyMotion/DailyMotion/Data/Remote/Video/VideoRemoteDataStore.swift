//
//  VideoRemoteDataStore.swift
//  DailyMotion
//
//  Created by Andrei-Stefan BURSUC on 24.06.2022.
//

import Foundation

typealias SuccessCompletionHandler = (_ response: GetVideoRepresentation) -> Void
typealias ErrorCompletionHandler = (_ error: DMError) -> Void

protocol VideoRemoteDataStoreProtocol {
    func getVideos(then success: @escaping SuccessCompletionHandler, error: @escaping ErrorCompletionHandler)
}

struct VideoRemoteDataStore: VideoRemoteDataStoreProtocol {

    // MARK: - VideoClientProtocol

    func getVideos(then success: @escaping SuccessCompletionHandler, error: @escaping ErrorCompletionHandler) {
        Client<GetVideoRepresentation>.get(.videos(channel: .news,
                                       limit: 20,
                                       fields: [.id, .thumbnail1080Url, .title, .description, .url, .createdTime])) { result in
            switch result {
            case .success(let model):
                if let model = model as? GetVideoRepresentation {
                    DispatchQueue.main.async {
                        success(model)
                    }
                }
            case .failure(let errrResponse):
                DispatchQueue.main.async {
                    error(errrResponse)
                }
            }
        }
    }
}

struct MockVideoRemoteDataStore: VideoRemoteDataStoreProtocol {

    // MARK: - Parameters
    var onSuccess: (() -> GetVideoRepresentation)

    // MARK: - VideoRemoteDataStoreProtocol

    func getVideos(then success: @escaping SuccessCompletionHandler, error: @escaping ErrorCompletionHandler) {
        success(onSuccess())
    }
}

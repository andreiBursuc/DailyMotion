//
//  Client.swift
//  DailyMotion
//
//  Created by Andrei-Stefan BURSUC on 23.06.2022.
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
    case put
}

typealias RequestCompletionHandler = (Result<Any, DMError>) -> Void

protocol ClientProtocol {
    static func get(_ endpoint: Endpoint, then handler: @escaping RequestCompletionHandler)
}

public struct Client<Model: Codable>: ClientProtocol {

    // MARK: - ClientProtocol

    static func get(_ endpoint: Endpoint, then handler: @escaping RequestCompletionHandler) {
        guard let url = endpoint.url else {
            return handler(.failure(.invalidUrl))
        }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue

        var dataTask: URLSessionDataTask?
        let defaultSession = URLSession(configuration: .default)

        dataTask = defaultSession.dataTask(with: request) { data, response, error in
            defer {
                dataTask = nil
            }

            if error != nil {
                return handler(.failure(.invalidUrl))
            } else if let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 {
                guard let model = self.parsedModel(with: data) else {
                    return handler(.failure(.decodingError))
                }
                return handler(.success(model))
            }
        }
        dataTask?.resume()
    }

    static func parsedModel(with data: Data) -> Model? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])

            let jsonData = try JSONSerialization.data(withJSONObject: json,
                                                      options: .prettyPrinted)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode(Model.self, from: jsonData)
            return model
        } catch {
            return nil
        }
    }
}

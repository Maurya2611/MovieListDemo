//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Chandresh on 30/9/19.
//  Copyright © 2019 Chandresh Maurya. All rights reserved.
//
import Foundation
import UIKit
enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}
enum Result<String> {
    case success
    case failure(String)
}
struct NetworkManager {
    static let environment: NetworkEnvironment = .production
    static let movieAPIKey = BaseConstant.movieAppKey
    let router = BaseNetworkRouter<GetMovielistApi>()
    func getNowPlayingListData(page: Int,
                               completion: @escaping (_ dataModel: BaseDataModel?,
        _ error: String?) -> Void) {
        router.request(.nowPlaying(page: page)) { data, response, error in
            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let apiResponse = try BaseDataModel.init(data: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getSimilarMovieData(movieID: Int,
                             completion: @escaping (_ dataModel: [MovieResult]?,
                             _ error: String?) -> Void) {
        router.request(.similar(movieId: movieID)) { data, response, error in
            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let apiResponse = try BaseDataModel.init(data: responseData)
                        completion(apiResponse.movieResults, nil)
                    } catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}

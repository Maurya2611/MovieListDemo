//  NetworkService.swift
//  NetworkLayer
//
//  Created by Chandresh on 30/9/19.
//  Copyright © 2019 Chandresh Maurya. All rights reserved.
//
import Foundation
public typealias ServerRouterCompletion = (_ dataModel: Data?, _ response: URLResponse?, _ error: Error?) -> Void
protocol NetworkRouter: class {
    associatedtype EndPoint: ServerRouterType
    func request(_ route: EndPoint, completion: @escaping ServerRouterCompletion)
    func cancel()
}
class BaseNetworkRouter<RouterType: ServerRouterType>: NetworkRouter {
    private var task: URLSessionTask?
    func request(_ route: RouterType, completion: @escaping ServerRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            ServerLogs.log(request: request)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    func cancel() {
        self.task?.cancel()
    }
    fileprivate func buildRequest(from route: RouterType) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters): try self.configureParameters(bodyParameters: bodyParameters,
                                                                                     bodyEncoding: bodyEncoding,
                                                                                     urlParameters: urlParameters,
                                                                                     request: &request)
            case .requestParametersWithHeaders(let bodyParameters,
                                               let bodyEncoding,
                                               let urlParameters,
                                               let additionalHeaders):
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

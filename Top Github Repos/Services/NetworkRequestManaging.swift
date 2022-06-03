//
//  NetworkRequestManaging.swift
//  Top Github Repos
//
//  Created by Mike Aymard on 6/2/22.
//

import Foundation

protocol NetworkRequestManaging {
    func sendRequest<T: Decodable>(requestPath: String, requestMethod: RequestMethod, headers: [String: String]?, queryParams: [String: Any]?, body: [String: String]?, responseModel: T.Type, onCompletion: @escaping (Result<T, RequestError>) -> Void)
}

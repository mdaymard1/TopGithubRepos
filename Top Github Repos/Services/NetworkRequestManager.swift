//
//  HTTPClient.swift
//  Top Github Repos
//
//  Created by Mike Aymard on 6/2/22.
//

import Foundation

class NetworkRequestManager: NetworkRequestManaging {

    func sendRequest<T>(requestPath: String, requestMethod: RequestMethod, headers: [String : String]?, queryParams: [String : Any]?, body: [String: String]?, responseModel: T.Type, onCompletion: @escaping (Result<T, RequestError>) -> Void) where T : Decodable {

        var fullRequestPath = requestPath
        if let queryParams = queryParams, let queryParameters = buildQueryParameters(queryParams) {
            if let encodedParameters = encodeQueryParameters(queryParameters) {
                fullRequestPath += encodedParameters
            } else {
                onCompletion(.failure(.invalidURL))
                return
            }
        }

        guard let url = URL(string: fullRequestPath) else {
            onCompletion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = requestMethod.rawValue
        request.allHTTPHeaderFields = headers

        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }

        print("calling github with \(fullRequestPath)")
        URLSession.shared.dataTask(with: request) { data, response, error in

            guard let response = response as? HTTPURLResponse , let data = data else {
                onCompletion(.failure(.noResponse))
                return
            }

            switch response.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                    onCompletion(.success(decodedResponse))
                } catch {
                    print("error: \(error)")
                    onCompletion(.failure(.decode))
                }
                return
            case 401:
                onCompletion(.failure(.unauthorized))
                return
            default:
                onCompletion(.failure(.unexpectedStatusCode))
                return
            }

        }.resume()
    }

    private func buildQueryParameters(_ queryParams: [String: Any]) -> String? {
        guard !queryParams.isEmpty else {
            return nil
        }
        var queryString = ""
        for (key, value) in queryParams {
            queryString += queryString.isEmpty ? "?" : "&"
            queryString += "\(key)=\(value)"
        }
        return queryString
    }

    private func encodeQueryParameters(_ queryParameters: String) -> String? {
        let unreserved = "?&="
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        return queryParameters.addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
}

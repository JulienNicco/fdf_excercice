//
//  AppNetwork.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import Combine
import Foundation

struct AppNetwork {
    func send<T: Decodable> (_ requestInfo: RequestInfo) -> AnyPublisher<T, Error> {
        guard let request = makeRequestFrom(requestInfo) else {
            return Fail(error: NSError(domain: "Invalid request", code: 0, userInfo: nil)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error -> Error in
                return error
            }
            .flatMap { data, response -> AnyPublisher<Data, Error> in
                guard let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) else {
                    return Just(data).setFailureType(to: Error.self).eraseToAnyPublisher()
                }
                print("Debug - AppNetwork - Request response error : \(httpResponse.statusCode)\n")
                
                let error = NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)
                return Fail(error: error).eraseToAnyPublisher()
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func makeRequestFrom(_ requestInfo: RequestInfo) -> URLRequest? {        
        guard let url = URL(string: requestInfo.url.toString) else {
            debugPrint("Debug - AppNetwork - Create request : URL creation failed")
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestInfo.method.rawValue
        
        if let parameters = requestInfo.parameters {
            if requestInfo.method == .get {
                let urlParameters = parameters.map { key, value in
                    return "\(key)=\(value)"
                }.joined(separator: "&")
                
                urlRequest.url = URL(string: "\(url)?\(urlParameters)")
            } else {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    urlRequest.httpBody = jsonData
                } catch {
                    debugPrint("Debug - AppNetwork - Create request : Body creation failed : \(error)")
                    return nil
                }
            }
        }
        
        return urlRequest
    }
}


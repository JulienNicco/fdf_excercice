//
//  AppNetwork.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import Combine
import Foundation

struct AppNetwork {
    func send<T: Decodable> (_ request: RequestInfo) -> AnyPublisher<T, Error> {
        guard let url = URL(string: request.url.stringUrl) else {
            return Fail(error: NSError(domain: "Invalid URL", code: 0, userInfo: nil)).eraseToAnyPublisher()
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        if let parameters = request.parameters {
            if request.method == .get {
                let urlParameters = parameters.map { key, value in
                    return "\(key)=\(value)"
                }.joined(separator: "&")
                
                urlRequest.url = URL(string: "\(url)?\(urlParameters)")
            } else {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    urlRequest.httpBody = jsonData
                } catch {
                    return Fail(error: error).eraseToAnyPublisher()
                }
            }
        }
        
        print("Debug - URL : \(urlRequest.url?.absoluteString)")
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError { error -> Error in
                return error
            }
            .flatMap { data, response -> AnyPublisher<Data, Error> in
                guard let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) else {
                    let stringData = String(decoding: data, as: UTF8.self)
                    print("Debug - response : \(stringData)")
                    return Just(data).setFailureType(to: Error.self).eraseToAnyPublisher()
                }
                print("Debug - response error : \(httpResponse.statusCode)")
                
                let error = NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: nil)
                return Fail(error: error).eraseToAnyPublisher()
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
    

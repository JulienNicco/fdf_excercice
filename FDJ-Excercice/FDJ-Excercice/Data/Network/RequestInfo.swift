//
//  RequestInfo.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import Foundation

struct RequestInfo {
    let url: ApiUrl
    let method: HTTPMethod
    let parameters: [String: Any]?
}

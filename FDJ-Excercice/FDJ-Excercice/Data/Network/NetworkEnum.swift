//
//  NetworkEnum.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum ApiUrl: String {
    case baseUrl = "https://www.thesportsdb.com/api/v1/json/50130162/"
    case league = "all_leagues.php"
    case team = "lookup_all_teams.php"
    
    var toString: String {
        switch self {
        case .baseUrl:
            return self.rawValue
        default:
            return ApiUrl.baseUrl.rawValue + self.rawValue
        }
    }
}

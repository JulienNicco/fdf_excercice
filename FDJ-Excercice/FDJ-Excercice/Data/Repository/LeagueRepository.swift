//
//  LeagueRepository.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import Foundation


import Combine

protocol LeagueRepositoryProtocol {
    func getAll() -> AnyPublisher<[LeagueModel], Error>
}

struct LeagueRepository: LeagueRepositoryProtocol {
    func getAll() -> AnyPublisher<[LeagueModel], Error> {
        let requestInfo = RequestInfo(url: .league, method: .get, parameters: nil)
        return AppNetwork().send(requestInfo)
            .map { (value: LeagueResponse) -> [LeagueModel] in
                return value.leagues.sorted { $0.strLeague < $1.strLeague }
            }
            .eraseToAnyPublisher()
    }
}

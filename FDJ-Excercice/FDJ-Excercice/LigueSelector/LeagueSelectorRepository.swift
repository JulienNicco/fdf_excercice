//
//  LeagueSelectorRepository.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import Foundation


import Combine

protocol LeagueSelectorRepositoryProtocol {
    func getLeagues() -> AnyPublisher<[LeagueModel], Error>
}

struct LeagueSelectorRepository: LeagueSelectorRepositoryProtocol {
    func getLeagues() -> AnyPublisher<[LeagueModel], Error> {
        let requestInfo = RequestInfo(url: .league, method: .get, parameters: nil)
        return AppNetwork().send(requestInfo)
            .map { (value: LeagueResponse) -> [LeagueModel] in
                return value.leagues
            }
            .eraseToAnyPublisher()
    }
}

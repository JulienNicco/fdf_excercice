//
//  TeamRepository.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import Combine

protocol TeamRepositoryProtocol {
    func getByLeague(_ league: LeagueModel) -> AnyPublisher<[TeamModel], Error>
}

struct TeamRepository: TeamRepositoryProtocol {
    func getByLeague(_ league: LeagueModel) -> AnyPublisher<[TeamModel], Error> {
        let requestInfo = RequestInfo(url: .team, method: .get, parameters: ["id":league.idLeague])
        return AppNetwork().send(requestInfo)
            .map { (value: TeamResponse) -> [TeamModel] in
                return value.teams.sorted { $0.strTeam < $1.strTeam }
            }
            .eraseToAnyPublisher()
    }
}

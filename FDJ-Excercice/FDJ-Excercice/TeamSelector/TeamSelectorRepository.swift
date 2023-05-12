//
//  TeamSelectorRepository.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import Combine

protocol TeamSelectorRepositoryProtocol {
    func getTeams(parameter: [String:Any]) -> AnyPublisher<[TeamModel], Error>
}

struct TeamSelectorRepository: TeamSelectorRepositoryProtocol {
    func getTeams(parameter: [String:Any]) -> AnyPublisher<[TeamModel], Error> {
        let requestInfo = RequestInfo(url: .team, method: .get, parameters: parameter)
        return AppNetwork().send(requestInfo)
    }
}

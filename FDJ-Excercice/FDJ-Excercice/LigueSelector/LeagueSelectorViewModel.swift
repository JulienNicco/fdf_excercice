//
//  LeagueSelectorViewModel.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import Combine
import Foundation

class LeagueSelectorViewModel: ObservableObject {
    var cancellable = Set<AnyCancellable>()
    let repo: LeagueSelectorRepository
    @Published var leagues: [LeagueModel]
    @Published var searchText = ""
    
    init(repository: LeagueSelectorRepository = LeagueSelectorRepository(),
         leagues:[LeagueModel] = []) {
        self.repo = repository
        self.leagues = leagues
        self.repo.getLeagues()
            .receive(on: RunLoop.main)
            .sink { result in
            switch result {
            case .failure(let error):
                print("Debug - error : \(error)")
            case .finished:
                print("Debug - finished")
            }
        } receiveValue: { [weak self] leagues in
            guard let self = self else { return }
            self.leagues = leagues
        }
        .store(in: &cancellable)
    }
}

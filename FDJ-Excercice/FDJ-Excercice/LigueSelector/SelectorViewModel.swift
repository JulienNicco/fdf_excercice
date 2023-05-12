//
//  SelectorViewModel.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import Combine
import Foundation

class SelectorViewModel: ObservableObject {
    var cancellable = Set<AnyCancellable>()
    let leagueRepo: LeagueRepository
    let teamRepo: TeamRepository
    var allLeagues: [LeagueModel]
    @Published var teams: [TeamModel]
    @Published var filteredLeagues: [LeagueModel]
    @Published var selectedLeague: LeagueModel?
    @Published var searchText = ""
    
    init(leagueRepository: LeagueRepository = LeagueRepository(),
         teamRepository: TeamRepository = TeamRepository(),
         leagues:[LeagueModel] = [],
         teams:[TeamModel] = []) {
        self.leagueRepo = leagueRepository
        self.teamRepo = teamRepository
        self.allLeagues = leagues
        self.filteredLeagues = leagues
        self.teams = teams
        setupBinding()
        refreshLeague()
    }
    
    func setupBinding() {
        $searchText.sink { [weak self] newValue in
            guard let self = self else { return }
            if newValue.isEmpty {
                self.filteredLeagues = self.allLeagues
                self.selectedLeague = nil
            } else {
                self.filteredLeagues = self.allLeagues.filter { $0.strLeague.lowercased().contains(newValue.lowercased()) }
            }
        }
        .store(in: &cancellable)
        
        $selectedLeague.sink { [weak self] league in
            guard let self = self else { return }
            if let league = league {
                self.getTeams(for: league)
            } else {
                self.teams = []
            }
        }
        .store(in: &cancellable)
    }
    
    func refreshLeague() {
        self.leagueRepo.getAll()
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
            self.allLeagues = leagues
            self.filteredLeagues = leagues
        }
        .store(in: &cancellable)
    }
    
    func getTeams(for league:LeagueModel) {
        self.teamRepo.getByLeague(league)
            .receive(on: RunLoop.main)
            .sink { result in
            switch result {
            case .failure(let error):
                print("Debug - error : \(error)")
            case .finished:
                print("Debug - finished")
            }
        } receiveValue: { [weak self] team in
            guard let self = self else { return }
            self.teams = team
        }
        .store(in: &cancellable)
    }
}

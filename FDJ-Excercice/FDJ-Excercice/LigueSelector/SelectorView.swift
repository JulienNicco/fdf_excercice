//
//  SelectorView.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import SwiftUI

struct SelectorView: View {
    @StateObject var vm: SelectorViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                teamsList()
                if vm.searchText.count >= 3 {
                    leaguesSuggestionList()
                }
            }
            .navigationTitle(Strings.titleScreenLeagueSelector)
        }
        .searchable(text: $vm.searchText)
    }
    
    func leaguesSuggestionList() -> some View {
        VStack {
            ScrollView {
                ForEach(vm.filteredLeagues, id: \.self) { league in
                    Button {
                        vm.selectedLeague = league
                    } label: {
                        Text(league.strLeague)
                    }
                }
            }
        }
    }
    
    func teamsList() -> some View {
        VStack {
            ScrollView {
                ForEach(vm.teams, id: \.self) { team in
                    NavigationLink {
                        DetailTeamView(team:team)
                    } label: {
                        Text(team.strTeam)
                    }
                }
            }
        }
    }
}

struct LeagueSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        SelectorView(vm: SelectorViewModel(leagues: [LeagueModel(), LeagueModel()]))
    }
}

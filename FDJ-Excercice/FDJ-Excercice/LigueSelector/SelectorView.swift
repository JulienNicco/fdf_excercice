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
            VStack {
                if let _ = vm.selectedLeague {
                    teamsList()
                } else {
                    if vm.searchText.count >= 3 {
                        leaguesSuggestionList()
                    }
                }
            }
            .navigationTitle(Strings.titleScreenLeagueSelector)
        }
        .searchable(text: $vm.searchText, prompt: Strings.placeHolderSearchBar)
    }
    
    func leaguesSuggestionList() -> some View {
        ScrollView {
            ForEach(vm.filteredLeagues, id: \.self) { league in
                Button {
                    vm.selectedLeague = league
                } label: {
                    HStack {
                        Text(league.strLeague)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 2)
                }
                .padding(.horizontal, 15)
                .buttonStyle(.plain)
            }
        }
    }
    
    func teamsList() -> some View {
        ScrollView {
            ForEach(vm.teams, id: \.self) { team in
                NavigationLink {
                    DetailTeamView(team:team)
                } label: {
                    VStack (alignment: .leading){
                        Text(team.strTeam)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
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

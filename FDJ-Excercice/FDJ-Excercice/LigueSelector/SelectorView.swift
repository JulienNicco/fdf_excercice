//
//  SelectorView.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct SelectorView: View {
    @StateObject var vm: SelectorViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if vm.isLoading {
                    ProgressView()
                } else if let _ = vm.selectedLeague {
                    teamsListView()
                } else {
                    if vm.searchText.count >= 3 {
                        leaguesSuggestionListView()
                    }
                }
            }
        }
        .searchable(text: $vm.searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: Strings.placeHolderSearchBar)
    }
    
    func leaguesSuggestionListView() -> some View {
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
    
    func teamsListView() -> some View {
        ScrollView {
            let columns = Array(repeating: GridItem(.flexible(), spacing: 15, alignment: .center), count: 2)
            LazyVGrid(columns: columns,spacing: 15) {
                ForEach(vm.teams, id:\.self) { team in
                    WebImage(url: URL(string: team.strTeamBadge))
                        .resizable()
                        .placeholder{Image(systemName: "photo").resizable().scaledToFit()}
                        .indicator(.activity)
                        .aspectRatio(contentMode: .fit)
                }
            }
            .padding(.horizontal, 15)
        }
    }
}

struct LeagueSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        SelectorView(vm: SelectorViewModel(leagues: [LeagueModel(), LeagueModel()]))
    }
}

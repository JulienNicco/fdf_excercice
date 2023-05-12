//
//  LeagueSelectorView.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import SwiftUI

struct LeagueSelectorView: View {
    @StateObject var vm:LeagueSelectorViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    ForEach(vm.leagues, id: \.self) { league in
                        NavigationLink {
                            Text(league.strLeague)
                        } label: {
                            Text(league.strLeague)
                        }
                    }
                }
            }
            .navigationTitle(Strings.titleScreenLeagueSelector)
        }
        .searchable(text: $vm.searchText)
    }
}

struct LeagueSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueSelectorView(vm: LeagueSelectorViewModel(leagues: [LeagueModel(), LeagueModel()]))
    }
}

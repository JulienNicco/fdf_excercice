//
//  DetailTeamView.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import SwiftUI

struct DetailTeamView: View {
    var team:TeamModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct DetailTeamView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTeamView(team:TeamModel())
    }
}

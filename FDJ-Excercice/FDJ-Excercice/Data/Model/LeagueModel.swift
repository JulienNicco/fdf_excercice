//
//  LeagueModel.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import Foundation

struct LeagueModel: Decodable, Hashable {
    var strLeague: String
    var idLeague: String
    var strSport: String
    var strLeagueAlternate: String?
    
    init() {
        self.strLeague = "Ligue 1"
        self.idLeague = "4334"
        self.strSport = "Soccer"
    }
}

struct LeagueResponse: Decodable {
    var leagues: [LeagueModel]
}

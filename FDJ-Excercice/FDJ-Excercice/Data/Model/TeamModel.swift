//
//  TeamModel.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import Foundation

struct TeamModel: Decodable, Hashable {
    var idTeam: String
    var strTeam: String
    var strSport: String
    var idLeague: String
    var strStadium: String
    var strTeamBadge: String
    
    init() {
        self.idTeam = "133714"
        self.strTeam = "Paris SG"
        self.strSport = "Soccer"
        self.idLeague = "4334"
        self.strStadium = "Parc des Princes"
        self.strTeamBadge = "https://www.thesportsdb.com/images/media/team/badge/rwqrrq1473504808.png"
    }
}

struct TeamResponse: Decodable {
    var teams: [TeamModel]
}

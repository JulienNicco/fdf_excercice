//
//  FDJ_ExcerciceTests.swift
//  FDJ-ExcerciceTests
//
//  Created by Julien Nicco on 12/05/2023.
//

import XCTest

final class FDJ_ExcerciceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMakeRequest() throws {
        let requestInfo = RequestInfo(url: .team, method: .get, parameters: ["id":61])
        if let urlRequest = AppNetwork().makeRequestFrom(requestInfo) {
            XCTAssertEqual(urlRequest.url?.absoluteString, "https://www.thesportsdb.com/api/v1/json/50130162/lookup_all_teams.php?id=61")
            XCTAssertEqual(urlRequest.httpMethod, "GET")
            XCTAssertNil(urlRequest.httpBody)
        } else {
            XCTFail("makeRequest method failed")
        }
    }
    
    func testSortingTeam() throws {
        let selectorVm = SelectorViewModel()
        var team1 = TeamModel()
        team1.strTeam = "Ajaccio"
        var team2 = TeamModel()
        team2.strTeam = "PSG"
        var team3 = TeamModel()
        team3.strTeam = "Marseille"
        var team4 = TeamModel()
        team4.strTeam = "Lyon"
        var team5 = TeamModel()
        team5.strTeam = "Toulouse"
        let listTeams = [team1, team2, team3]
        selectorVm.setTeams(listTeams)
        
        let teamNames = listTeams.enumerated()
            .filter { $0.offset % 2 == 0 }
            .map { $0.element }
            .sorted { $0.strTeam > $1.strTeam }

        let isSorted = selectorVm.teams == teamNames
        XCTAssertTrue(isSorted, "Sorting Team KO")
    }
}

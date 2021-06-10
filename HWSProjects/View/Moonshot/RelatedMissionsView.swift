//
//  RelatedMissionsView.swift
//  HWSProjects
//
//  Created by Emile Wong on 6/6/2021.
//

import SwiftUI

struct RelatedMissionsView: View {
    // MARK: - PROPERTIES

    let astronautName: String
    var missions: [Mission]
    var relatedMissions: [Mission]
    
    init(astronautName: String, missions: [Mission]){
        self.missions = missions
        self.astronautName = astronautName
        self.relatedMissions = [Mission]()
        var matches = [Mission]()
        for mission in missions{
            for member in mission.crew {
                if member.name == astronautName {
                    matches.append(mission)
                }else {
                    fatalError("Missing \(member)")
                }
                
            }
        }
        self.relatedMissions = matches
    }
    // MARK: - BODY
    var body: some View {
        
        Text("\(relatedMissions.count)")
    }
}
// MARK: - PREVIEW
struct RelatedMissionsView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        RelatedMissionsView(astronautName: "grissom", missions: missions)
    }
}

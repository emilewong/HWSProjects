//
//  MoonShotView.swift
//  HWSProjects
//
//  Created by Emile Wong on 1/6/2021.
//

import SwiftUI

struct MoonShotView: View {
    // MARK: - PROPERTIES
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    // MARK: - BODY
    var body: some View {
        NavigationView{
            List(missions){ mission in
                NavigationLink(
                    destination: MissionView(mission: mission, astronauts: self.astronauts),
                    label: {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                        
                        VStack(alignment: .leading, content: {
                            Text(mission.displayName)
                                .font(.headline)
                            Text(mission.formattedLaunchDate)
                            
                        })
                    }) //: NAVIGATION
            } //: LIST
            .navigationBarTitle("Moonshot")
        } //: NAVIGATION
    }
}
// MARK: - PREVIEW
struct MoonShotView_Previews: PreviewProvider {
    static var previews: some View {
        MoonShotView()
    }
}

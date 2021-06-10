//
//  AstronautView.swift
//  HWSProjects
//
//  Created by Emile Wong on 1/6/2021.
//

import SwiftUI

struct AstronautView: View {
    // MARK: - PROPERTIES
    let astronaut: Astronaut

    // MARK: - BODY
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
//                    RelatedMissionsView(astronautName: astronaut.id )
                } //: VStack
            } //: SCROLL
            
        } //: GeometryReader
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}
// MARK: - PREVIEW
struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}

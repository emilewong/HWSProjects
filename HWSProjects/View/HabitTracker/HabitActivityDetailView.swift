//
//  HabitActivityDetailView.swift
//  HWSProjects
//
//  Created by Emile Wong on 3/6/2021.
//

import SwiftUI

struct HabitActivityDetailView: View {
    // MARK: - PROPERTIES
    @ObservedObject var activities: Activities
    var activity: Activity
    
    func addCounter() {
       
    }
    func subtractCounter() {

    }
    // MARK: - BODY
    var body: some View {
        Form{
            VStack{
                Text(activity.name)
                    .font(.title)
                Text(activity.description)
                    .font(.headline)
                Spacer()
            } //: VSTACK
            HStack {
                Spacer()
                Button(action: {
                    if activity.counter > 0 {
                        // counter subtract 1
                    }
                }, label: {
                    Image(systemName: "minus.square")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                })
                
                Text("Couter: \(activity.counter)")
                    .padding(.horizontal)
                Button(action: {
                    // counter add 1
                }, label: {
                    Image(systemName: "plus.square")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                })
                Spacer()
            }
        } //: FORM
    }
}
// MARK: - PREVIEW

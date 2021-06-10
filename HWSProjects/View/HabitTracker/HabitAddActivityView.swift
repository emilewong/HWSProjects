//
//  HabitAddActivityView.swift
//  HWSProjects
//
//  Created by Emile Wong on 3/6/2021.
//

import SwiftUI

struct HabitAddActivityView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var description = ""
    @State var showingAlert = false
    @ObservedObject var activities: Activities
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Activity", text: $name)
                TextField("Description", text: $description)
            } //: FORM
            .navigationBarTitle("Add new activity")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        if name != "" {
                            let activity = Activity(name: self.name, description: self.description, counter: 0)
                            self.activities.items.append(activity)
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            showingAlert = true
                        }
                    }, label: {
                        Text("Save")
                    })
            )
        } //: NAVIGATION
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("Error"), message: Text("Invalid activity count"), dismissButton: .default(Text("Ok")))
        })
    }
}

struct HabitAddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        HabitAddActivityView(activities: Activities())
    }
}

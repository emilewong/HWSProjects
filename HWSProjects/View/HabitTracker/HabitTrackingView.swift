//
//  HabitTrackingView.swift
//  HWSProjects
//
//  Created by Emile Wong on 2/6/2021.
//

import SwiftUI

struct Activity: Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    let counter: Int
}

class Activities: ObservableObject {
    
    @Published var items = [Activity](){
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.setValue(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let activities = UserDefaults.standard.data(forKey: "Activities") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self , from: activities){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct HabitTrackingView: View {
    // MARK: - PROPERTIES
    @ObservedObject var activities = Activities()
    @State var showingAddActivity = false
    
    // MARK: - FUNCITONS
    func removeActivites(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                List {
                    ForEach(activities.items) { item in
//                        NavigationLink(destination: HabitActivityDetailView(activities: item)){
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Image(systemName: "\(item.counter).circle")
                            }
                            Spacer()
                            Text("Counter: \(item.counter)")
                                .foregroundColor(item.counter < 10 ? Color.green : item.counter < 100 ? Color.orange : Color.red)
                        }
//                        } //: NAVIGATION
                    } // LOOP
                    .onDelete(perform: { indexSet in
                        removeActivites(at: indexSet)
                    })
                } //: LIST
                .sheet(isPresented: $showingAddActivity, content: {
                    HabitAddActivityView(activities: self.activities)
                    Text("Add activity")
                })
            } //: VSTACK
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading, content: {
                    EditButton()
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        showingAddActivity = true
                    }, label: {
                        Image(systemName: "plus")
                            .font(.title)
                    })
                })
            }
        } //: NAVIGATION
    }
}

struct HabitTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        HabitTrackingView()
    }
}

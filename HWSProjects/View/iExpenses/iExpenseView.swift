//
//  iExpenseView.swift
//  HWSProjects
//
//  Created by Emile Wong on 29/5/2021.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses: ObservableObject {

    @Published var items = [ExpenseItem](){
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self , from: items){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}
struct iExpenseView: View {
    // MARK: - PROPERTIES
    @ObservedObject var expenses = Expenses()
    @State var showingAddExpense = false
    
    
    // MARK: - FUNCITONS
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView{
            VStack{
                List {
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text("$\(item.amount,specifier: "%.2f")")
                                .foregroundColor(item.amount < 10 ? Color.green : item.amount < 100 ? Color.orange : Color.red)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        removeItems(at: indexSet)
                    })
                } //: LIST
                .sheet(isPresented: $showingAddExpense, content: {
                    iExpenseAddItemView(expenses: self.expenses)
                })
            } //: VSTACK
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading, content: {
                    EditButton()
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        showingAddExpense = true
                    }, label: {
                        Image(systemName: "plus")
                            .font(.title)
                    })
                })
            }
        } //: NAVIGATION
    }
}

// MARK: - PREVIEW
struct iExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        iExpenseView()
    }
}

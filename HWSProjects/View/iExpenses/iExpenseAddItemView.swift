//
//  iExpenseAddItemView.swift
//  HWSProjects
//
//  Created by Emile Wong on 1/6/2021.
//

import SwiftUI

struct iExpenseAddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var type = ""
    @State private var amount = ""
    @State var showingAlert = false
    @ObservedObject var expenses: Expenses
    
    static let types = ["Personal","Business"]
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(Self.types, id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
            } //: FORM
            .navigationBarTitle("Add new expense")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        if let actualAmount = Double(self.amount) {
                            let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                            self.expenses.items.append(item)
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
            Alert(title: Text("Error"), message: Text("Invalid Amount"), dismissButton: .default(Text("Ok")))
        })
    }
}

struct iExpenseAddItemView_Previews: PreviewProvider {
    static var previews: some View {
        iExpenseAddItemView(expenses: Expenses())
    }
}



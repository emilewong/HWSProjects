//
//  WeSplitView.swift
//  HWSProjects
//
//  Created by Emile Wong on 23/5/2021.
//

import SwiftUI

struct Title: ViewModifier {
    var haveTip: Bool = false
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(haveTip ? Color.green : Color.red)
    }
}

extension View {
    func titleStyle(withTip haveTip: Bool) -> some View {
        self.modifier(Title(haveTip: haveTip))
    }
}

struct WeSplitView: View {
    // MARK: - PROPERTIES
    @State private var checkAmount: String = ""
    @State private var numberOfPeople: Int = 0
    @State private var tipPercentage: Int = 2
    
    let tipPercentages = [5, 10, 15, 20,25, 0]
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack{
                Rectangle()
                    .background(Color.pink)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.3)
                    .onTapGesture {
                        hideKeyboard()
                    }
                VStack(spacing: 15) {
                    Section(header: Text("Number of people")) {
                        Picker(selection: $numberOfPeople, label: Text("Number of People"), content: {
                            ForEach( 2..<100) { person in
                                Text("\(person)")
                                    .rotationEffect(Angle(degrees: 90))
                            }
                        }) //: PICKER
                        .pickerStyle(WheelPickerStyle())
                        .rotationEffect(Angle(degrees: -90))
                        .frame(maxHeight: 50)
                        .clipped()
                        .labelsHidden()
                        
                    } //: SECTION

                    Section(header: Text("Meal Amount")) {
                        TextField("Amount to split", text: $checkAmount)
                            .keyboardType(.decimalPad)
                            .padding()
                            .frame(width: 200, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.gray)
                            .cornerRadius(20)
                    }

                    
                    Section (header: Text("How much you want to tip?")){
                        Picker(selection: $tipPercentage, label: Text("Tip Percentage"), content: {
                            ForEach(0..<tipPercentages.count) { tip in
                                Text("\(self.tipPercentages[tip])%")
                            }
                        })
                        .pickerStyle(SegmentedPickerStyle())
                        
                    } //: SECTION

                    Section () {
                        Text("Check Amount: \( checkAmount == "" ? "0.00" : checkAmount)")
                        Text("Amount + Tips: \(grandTotal, specifier: "%.2f")")
                        Text("Amount per person: \(totalPerPerson, specifier: "%.2f")")
                            .titleStyle(withTip: tipPercentages[tipPercentage] == 0 ? false : true)
                    } //: SECTION
                    
                } //: VSTACK
                Spacer()
                
            } //: ZSTACK
            .navigationTitle("WeSplit")
            .foregroundColor(.white)
            .font(.title3)
        } //: NAVIGATION
    }
}
// MARK: - PREVIEW
struct WeSplitView_Previews: PreviewProvider {
    static var previews: some View {
        WeSplitView()
    }
}

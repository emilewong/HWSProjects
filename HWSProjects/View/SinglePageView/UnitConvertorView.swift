//
//  UnitConvertorView.swift
//  HWSProjects
//
//  Created by Emile Wong on 23/5/2021.
//

import SwiftUI

struct UnitConvertorView: View {
    // MARK: - PROPERTIES
    @State private var inputAmount: String = ""
    @State private var outputAmount: String = ""
    @State private var inputUnit: Int = 2
    @State private var outputUnit: Int = 4
    @State private var answer: Double = 0.00
    
    let conversionUnits = ["grain", "drachm", "ounce","stone", "pound", "kilogram", "gram"]
    
    func convertUnit() -> Double {
        let inUnit: String = conversionUnits[inputUnit]
        let outUnit: String = conversionUnits[outputUnit]
        let inAmount = Double(inputAmount) ?? 0
        var outAmount = Double(outputAmount) ?? 0
        var totalGrams: Double = 0.00
        
        switch inUnit {
            case "grain" :
                totalGrams = inAmount * 0.06479891
            case "drachm" :
                totalGrams = inAmount * 1.7718451953125
            case "ounce" :
                totalGrams = inAmount * 28.349523125
            case "pound" :
                totalGrams = inAmount * 453.59237
            case "stone" :
                totalGrams = inAmount * 6350.29318
            case "kilogram" :
                totalGrams = inAmount * 1000
            default:
                totalGrams = inAmount
        }
        
        switch outUnit {
            case "grain" :
                outAmount = totalGrams / 0.06479891
            case "drachm" :
                outAmount = totalGrams / 1.7718451953125
            case "ounce" :
                outAmount = totalGrams / 28.349523125
            case "pound" :
                outAmount = totalGrams / 453.59237
            case "stone" :
                outAmount = totalGrams / 6350.29318
            case "kilogram" :
                outAmount = totalGrams / 1000
            default:
                outAmount = totalGrams
        }
        return outAmount
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack{
                Rectangle()
                    .background(Color.orange)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .opacity(0.2)
                    .onTapGesture {
                        hideKeyboard()
                    }
                VStack {
                    VStack{
                        HStack{
                            Text("From:")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                
                            Spacer()
                            TextField("Unit", text: $inputAmount)
                                .keyboardType(.decimalPad)
                                .font(.title2)
                                .frame(width: 250, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.gray)
                                .cornerRadius(15)
                                .padding(.bottom, 10)
                        }
                        .foregroundColor(Color.green)
                        Picker(selection: $inputUnit, label: Text("From Unit:"), content: {
                            ForEach(0..<conversionUnits.count) { unit in
                                Text("\(self.conversionUnits[unit])")
                            }
                        })
                        .pickerStyle(SegmentedPickerStyle())
                        .background(Color.green)
                        .cornerRadius(15)
                        .frame(height: 100)
                    } //: VSTACK
                    .padding(.bottom, 10)
                    
                   
                    VStack{
                        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                            Text("To:")
                            Spacer()
                            Text("\(answer, specifier: conversionUnits[outputUnit] == "kilogram" ? "%.8f" : conversionUnits[outputUnit] == "pound" ? "%.6f" : "%.4f")")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(.black)
                                
                        })
                        .foregroundColor(Color.pink)
                        
                        Picker(selection: $outputUnit, label: Text("To Unit:"), content: {
                            ForEach(0..<conversionUnits.count) { unit in
                                Text("\(self.conversionUnits[unit])")
                            }
                        })
                        .pickerStyle(SegmentedPickerStyle())
                        .background(Color.pink)
                        .cornerRadius(15)
                        .onTapGesture(perform: {
                            answer = convertUnit()
                        })
                    } //: VSTACK
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    
                    Button(action: {
                        answer = convertUnit()
                    }, label: {
                        Text("Convert".uppercased())
                    }) //: BUTTON
                    .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .padding(.top, 50)
                    
                    
        
                    Spacer()
                } //: VSTACK
                .padding(10)
                
            } //: ZSTACK
            .navigationTitle("Weight Unit Conversions")
            .foregroundColor(.white)
        } //: NAVIGATION
    }
}

// MARK: - PREVIEW
struct UnitConvertorView_Previews: PreviewProvider {
    static var previews: some View {
        UnitConvertorView()
    }
}

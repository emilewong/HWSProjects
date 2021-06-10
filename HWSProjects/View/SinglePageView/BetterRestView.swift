//
//  BetterRestView.swift
//  HWSProjects
//
//  Created by Emile Wong on 26/5/2021.
//

import SwiftUI
import CoreML

struct BetterRestView: View {
    // MARK: - PROPERTIES
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    
    // MARK: - FUNCTIONS
        func calculateBedtime() {
            let model: SleepCalculator = {
                do {
                    let config = MLModelConfiguration()
                    return try SleepCalculator(configuration: config)
                } catch {
                    print(error)
                    fatalError("Couldn't create SleepCalculator")
                }
            }()
    
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
    
            do {
                let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
    
                let sleepTime = wakeUp - prediction.actualSleep
    
                let formatter = DateFormatter()
                formatter.timeStyle = .short
    
                alertMessage = formatter.string(from: sleepTime)
                alertTitle = "Your ideal bedtime is…"
            } catch {
                alertTitle = "Error"
                alertMessage = "Sorry, there was a problem calculating your bedtime."
    
            }
            showAlert = true
        }
    
    // MARK: - BODY
    var body: some View {
        NavigationView{
            Form {
                VStack{
                    VStack(alignment: .leading, spacing: 0) {
                        Text("When do you want to wakeup")
                            .font(.headline)
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                    } //: VSTACk
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Text("Desire amount of sleep")
                            .font(.headline)
                        Stepper(value: $sleepAmount, in: 4...16, step: 0.25){
                            Text("\(sleepAmount, specifier: "%g") hours")
                        } //: STEPPER
                        
                    } //: VSTACK
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Coffee amount intake")
                            .font(.headline)
                        Stepper(value: $coffeeAmount, in: 1...20){
                            if ( coffeeAmount == 1) {
                                Text("1 cup")
                            } else {
                                Text("\(coffeeAmount) cups")
                            }
                        } //: STEPPER
                        Spacer()
                    } //: VSTACK
                    
                } //: VSTACK
                .navigationBarTitle("Better Rest")
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            self.calculateBedtime()
//                            print("button is tapped")
                        }, label: {
                            Text("Calculate")
                        })
                )
                alert(isPresented: $showAlert, content: {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
                })
            } //: FORM
            
        } //: NAVIGATION
    } //: VIEW
}
// MARK: - PREVIEW
struct BetterRestView_Previews: PreviewProvider {
    static var previews: some View {
        BetterRestView()
    }
}

//
//  GuessTheFlagView.swift
//  HWSProjects
//
//  Created by Emile Wong on 24/5/2021.
//

import SwiftUI

struct GuessTheFlagView: View {
    // MARK: - PROPERTIES
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var numberOfGames: Int = 0
    @State private var scores: Int = 0
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showingAlert = false
    
    @State private var animationAmount = 0.0
    @State private var clickedButton: Int = 999
    
    
    // MARK: - FUNCTION
    func checkWinner(_ number: Int) {
        if numberOfGames >= 10 {
            alertTitle = "Game Over"
            alertMessage = "Start a new game"
        } else if number == correctAnswer {
            alertTitle = "Correct"
            alertMessage = "You won"
            scores += 1
            withAnimation {
                animationAmount += 360
            }
        } else {
            alertTitle = "Wrong"
            alertMessage = "You lose, try again"
        }
        showingAlert = true

    }
    
    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
        numberOfGames += 1
        showingAlert = false
        clickedButton = 999
    }
    
    func newGame() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
        numberOfGames = 0
        scores = 0
        showingAlert = false
        clickedButton = 999
    }
    
    
    // MARK: - BODY
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    
                    Text("\(countries[correctAnswer])")
                        .foregroundColor(.white)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(.black)
                } //: VSTACK
                
                ForEach (0..<3) { number in
                    Button(action: {
                        checkWinner(number)
                        clickedButton = number
                    }, label: {
                        Image((clickedButton != correctAnswer && number == clickedButton) ? "" : "\(countries[number])")
                            .resizable()
                            .frame(width: 200, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 4))
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                            .opacity(!showingAlert ? 1 : number != correctAnswer ? 0.25 : 1)
                            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: number == correctAnswer ? 1 : 0, z: 0))
                    })
                    .alert(isPresented: $showingAlert, content: {
                        Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")){
                            if numberOfGames < 10 {
                                askQuestion()
                                
                            } else {
                                newGame()
                            }
                            
                        })
                    })
                    
                    
                }
                Text("Your score is \(scores) out of \(numberOfGames) games")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.black)
                Spacer()
                
                
            } //: VSTACK
        } //: ZSTACK
    }
}


// MARK: - PREVIEW
struct GuessTheFlagView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlagView()
    }
}

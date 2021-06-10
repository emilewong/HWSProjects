//
//  RockPaperScissorsView.swift
//  HWSProjects
//
//  Created by Emile Wong on 25/5/2021.
//

import SwiftUI

struct RockPaperScissorsView: View {
    // MARK: - PROPERTIES
    @State private var gameOver: Bool = true
    @State private var showResult = false
    @State private var restart: Bool = false
    @State private var nextGuess: Bool = false
    @State private var scores: Int = 0
    @State private var numberOfGames: Int = 10
    @State private var numberOfTries: Int = 1
    @State private var move: Int = Int.random(in: 0...2)
    @State private var choice : Bool = Bool.random()
    @State private var gameItems: [String] = ["rock", "paper", "scissors"]
    
    // MARK: - FUNCTIONS
    func isGameOver() {
        if numberOfTries > numberOfGames {
            gameOver = true
        } else {
            gameOver = false
            
        }
    }
    func checkResult(_ number: Int) {
        if !showResult {
            if choice {
                if gameItems[number] == "paper" && gameItems[move] == "rock" {
                    scores += 1
                } else if gameItems[number] == "rock" && gameItems[move] == "scissors" {
                    scores += 1
                } else if gameItems[number] == "scissors" && gameItems[move] == "paper" {
                    scores += 1
                }
            } else {
                if gameItems[number] == "rock" && gameItems[move] == "paper" {
                    scores += 1
                } else if gameItems[number] == "scissors" && gameItems[move] == "rock" {
                    scores += 1
                } else if gameItems[number] == "paper" && gameItems[move] == "scissors" {
                    scores += 1
                }
            }
            showResult = true
            nextGuess = false
            
        }
    }
    func newGuess() {
        if !nextGuess && showResult{
            move = Int.random(in: 0...2)
            choice = Bool.random()
            nextGuess = true
            showResult = false
            numberOfTries += 1
        }
    }
    func restartGame() {
        move = Int.random(in: 0...2)
        choice = Bool.random()
        restart = true
        nextGuess = true
        showResult = false
        scores = 0
        numberOfTries = 1
        gameOver = false
        
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView{
                ZStack{
                    RadialGradient(gradient: Gradient(colors: [Color.green, Color.orange]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: /*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/, endRadius: /*@START_MENU_TOKEN@*/500/*@END_MENU_TOKEN@*/)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    VStack(spacing: 10){
                        Image(showResult ? gameItems[move] : "Italy")
                            .resizable()
                            .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .clipShape(Rectangle())
                            .overlay(Rectangle().stroke(Color.white, lineWidth: 1))
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                            .rotationEffect(Angle(degrees: showResult ? 180 : 0), anchor: .center)
                        Spacer()
                        VStack{
                            Text(gameOver ? "Game Over" : "Score: \(scores) out of \(numberOfTries)").fontWeight(.black)
                                .font(.system(size: 24, weight: .bold, design: .default))
                            Text("Tap one picture").fontWeight(.black)
                                .font(.system(size: 18, weight: .bold, design: .default))
                        } //:VSTACK
                        .frame(width: 300, height: 100, alignment: .center)
                        .background(Color.orange)
                        .alert(isPresented: $nextGuess) {
                            Alert(title: Text("Try to"),
                                  message: Text(choice ? "Win" : "Lose"),
                                  dismissButton: .default(Text("OK")){
                                nextGuess = false
                            })
                        }
                        Spacer()
                        HStack(spacing: 10){
                            ForEach (0..<3) { number in
                                Button(action: {
                                    isGameOver()
                                    if !gameOver{
                                        checkResult(number)
                                    }
                                }, label: {
                                    Image("\(gameItems[number])")
                                        .resizable()
                                        .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .clipShape(Rectangle())
                                        .overlay(Rectangle().stroke(Color.white, lineWidth: 1))
                                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                                })
                            }
                        } //: HSTACK
                        Spacer()
                        Button(action: {
                            if gameOver{
                                restartGame()
                            } else {
                                newGuess()
                            }
                        }, label: {
                            Text(gameOver ? "New Game" : "Next Guess")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        })
                        .frame(width: 250, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(gameOver ? Color.red : showResult ? Color.green : Color.gray)
                        .cornerRadius(10)
                        Spacer()
                    } //:VSTACK
                } //: ZSTACK
                .navigationBarTitle(Text("Rock Paper Scissors"))
        } //: NAVIGATION
        
    } //: SOME VIEW
} //: STRUCT VIEW

// MARK: - PREVIEW
struct RockPaperScissorsView_Previews: PreviewProvider {
    static var previews: some View {
        RockPaperScissorsView()
    }
}

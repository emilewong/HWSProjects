//
//  MyNavigationView.swift
//  HWSProjects
//
//  Created by Emile Wong on 26/5/2021.
//

import SwiftUI

struct MyNavigationView: View {
    // MARK: - PROPERTIES
    @State private var isNavigationBarHidden : Bool = true
    
    var body: some View {
        
        NavigationView{
            VStack{
                List{
                    NavigationLink(
                        destination: WeSplitView(),
                        label: {
                            Image(systemName: "person.3")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(( Color.secondary))
                            Text("WeSplit")
                        }
                    ) //: LINK
                    
                    
                    NavigationLink(
                        destination: GuessTheFlagView(),
                        label: {
                            Image(systemName: "flag")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(( Color.secondary))
                            Text("Guess The Flag Game")
                        }
                    ) //: LINK
                    NavigationLink(
                        destination: UnitConvertorView(),
                        label: {
                            Image(systemName: "scalemass")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(( Color.secondary))
                            Text("Unit Convertor")
                        }
                    ) //: LINK
                    
                    NavigationLink(
                        destination: RockPaperScissorsView(),
                        label: {
                            Image(systemName: "gamecontroller.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(( Color.secondary))
                            Text("Rock Paper Scissors Game")
                        }
                    ) //: LINK
                    
                    NavigationLink(
                        destination: BetterRestView(),
                        label: {
                            Image(systemName: "moon.zzz")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(( Color.secondary))
                            Text("Better Rest")
                        }
                    ) //: LINK
                    
                    NavigationLink(
                        destination: WordScrambleView(),
                        label: {
                            Image(systemName: "a.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(( Color.secondary))
                            Text("Word Scramble Game")
                        }
                    ) //: LINK
                    
                    NavigationLink(
                        destination: iExpenseView(),
                        label: {
                            Image(systemName: "dollarsign.square")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(( Color.secondary))
                            Text("iExpense")
                        }
                    ) //: LINK
                    
                    NavigationLink(
                        destination: MoonShotView(),
                        label: {
                            Image(systemName: "moon.stars")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(( Color.secondary))
                            Text("Moonshot")
                        }
                    ) //: LINK
                    
                    NavigationLink(
                        destination: DrawingView(),
                        label: {
                            Image(systemName: "lasso.sparkles")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(( Color.secondary))
                            Text("Drawing - Spirograph")
                        }
                    ) //: LINK
                    
                    NavigationLink(
                        destination: HabitTrackingView(),
                        label: {
                            Image(systemName: "memories.badge.plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(( Color.secondary))
                            Text("Habit Tracking")
                        }
                    ) //: LINK
                } //: LIST
                
                List{
                    NavigationLink(
                        destination: CupcakeCornerView(),
                        label: {
                            Image(systemName: "cart.badge.plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(( Color.secondary))
                            Text("Cup Cake Corner")
                        }
                    ) //: LINK
                    
                    NavigationLink(
                        destination: BookWormView(),
                        label: {
                            Image(systemName: "books.vertical")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(( Color.secondary))
                            Text("Book Worm")
                        }
                        
                    ) //: LINK
                    
                } //: LIST
            } //: VSTACK
            .navigationTitle("My Utilities App")
        } //: NAVIGATION
        
    }
}

struct MyNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MyNavigationView()
    }
}

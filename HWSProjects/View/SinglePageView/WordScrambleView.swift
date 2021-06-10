//
//  WordScrambleView.swift
//  HWSProjects
//
//  Created by Emile Wong on 26/5/2021.
//

import SwiftUI

struct WordScrambleView: View {
    // MARK: - PROPERTIES
    @State private var usedWords = [String]()
    @State private var totalLetters: Int = 0
    @State private var rootWord: String = ""
    @State private var newWord: String = ""
    
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    @State private var showingError: Bool = false
    
    
    // MARK: - FUNCTIONS
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", Message: "Be more original")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", Message: "You cannot just make them up")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", Message: "That is not a real word")
            return
        }
        
        guard isEligible(word: answer) else {
            wordError(title: "Word not eligible", Message: "Either too short or same as rootword")
            return
        }
        
        usedWords.insert(answer, at: 0)
        totalLetters += answer.count
        newWord = ""
    }
    
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                
                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                
                // If we are here everything has worked, so we can exit
                print("file loaded successfully")
                return
            }
        }
        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isEligible(word: String) -> Bool {
        if word.count < 3 || word == rootWord{
            return false
        } else {
            return true
        }
    }
    
    func wordError(title: String, Message: String) {
        errorTitle = title
        errorMessage = Message
        showingError = true
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your new word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                Spacer()
                Text("You entered \(usedWords.count) words, a total of \(totalLetters) letters")
                
            } //: VSTACK
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        self.startGame()
                        //                            print("button is tapped")
                    }, label: {
                        Text("New Game".uppercased())
                    })
            )
            .alert(isPresented: $showingError, content: {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
            })
        } //: NAVIGATION
    }
}
// MARK: - PREVIEW
struct WordScrambleView_Previews: PreviewProvider {
    static var previews: some View {
        WordScrambleView()
    }
}

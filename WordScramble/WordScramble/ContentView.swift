//
//  ContentView.swift
//  WordScramble
//
//  Created by Dipti Yadav on 6/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    
    var body: some View {
        NavigationView {
               List {
                   Section(header: Text("Score: \(score)")) {}
                   Section {
                       TextField("Enter your word", text: $newWord)
                           .textInputAutocapitalization(.never)
                   }
                   Section {
                       ForEach(usedWords, id: \.self) { word in
                           HStack{
                               Image(systemName: "\(word.count).circle")
                               Text(word)
                           }
                       }
                   }
               }
               .navigationTitle(rootWord)
               .onSubmit(addNewWord)
               .onAppear(perform: startGame)
               .toolbar {
                   Button(action: startAgain, label: {
                       Image(systemName: "arrow.counterclockwise")
                   }).padding(.trailing)
               }
               .alert(errorTitle, isPresented: $showingError) {
                   Button("OK", role: .cancel) { }
               } message: {
                   Text(errorMessage)
               }
        }
    }
    
    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard answer.count > 2 else {
            wordError(title: "Word have less than three letters", message: "Guess the word with more than two letters.")
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        score += 1
       
        newWord = ""
    }
    
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
        
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
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
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func startAgain(){
        
        usedWords = [String]()
        rootWord = ""
        newWord = ""
        errorTitle = ""
        errorMessage = ""
        showingError = false
        score  =  0
        startGame()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  WeSplit
//
//  Created by Dipti Yadav on 6/20/23.
//

import SwiftUI

struct ContentView: View {
    @State private var tabCount = 0
    
    var body: some View {
//        NavigationView {
//            Form{
//                Section {
//                    Text("Hello, world!")
//                }
//            }
//            .navigationTitle("SwiftUI")
//            .navigationBarTitleDisplayMode(.inline)
//        }
        Button("Tap Count: \(tabCount)"){
            tabCount += 1
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

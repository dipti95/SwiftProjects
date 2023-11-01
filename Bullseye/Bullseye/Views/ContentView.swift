
//
//  ContentView.swift
//  Bullseye
//
//  Created by Dipti Yadav on 9/1/23.
//

import SwiftUI

struct ContentView: View {
  @State private var alertIsVisible: Bool = false
  @State private var sliderValue: Double = 50.0
  
  
  var body: some View {
    VStack {
      Text("🎯🎯🎯\nPUT THE BULLSEYES AS CLOSE AS YOU CAN TO")
        .bold()
        .multilineTextAlignment(.center)
        .lineSpacing(4.0)
        .font(.footnote)
        .kerning(2.0)
      Text("89")
        .kerning(-1)
        .font(.largeTitle)
        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
      HStack {
        Text("1")
          .bold()
        Slider(value: $sliderValue, in:1.0...100.0)
        Text("100")
          .bold()
      }
      Button("Hit me") {
        alertIsVisible = true
      }
      .alert(
        "Hello there!",
        isPresented: $alertIsVisible,
        actions: {
          Button("Awesome") {
            print("Alert Closed")
          }
        },
        message: {
          var roundedValue: Int = Int(sliderValue.rounded())
          Text("The slider's value is \(roundedValue)")
        }
        
      )
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

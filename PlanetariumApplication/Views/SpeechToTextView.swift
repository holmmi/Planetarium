//
//  TextToSpeechView.swift
//  PlanetariumApplication
//
//  Created by iosdev on 26.11.2021.
//

import SwiftUI

struct SpeechToTextView: View {
    @State private var text = ""
    @State private var speechRecognizer: SpeechRecognizer!
    @State private var btnColor = Color(.blue)
    @State private var btnPressed: Bool = false
    @State private var clr = Color(.blue)
   // @State private var isRecording = false
    
    var body: some View {
        NavigationView {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search...", text: $text)
                Button(action: initTextToSpeech) {
                    Image(systemName: "mic")
                        .foregroundColor(clr)
                }
                }
            
            
                
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onAppear() {
                speechRecognizer = SpeechRecognizer(clr: $clr)
            }
            
        }
        //.onAppear() {
            //clrStore = colorStore(isRecording)
        //}
    
    
    private func initTextToSpeech() {
        //print("type:", type(of: speechRecognizer.store.isRecording))
        if !btnPressed {
            speechRecognizer.record(to: $text)
            btnPressed = true
        }
        else {
            speechRecognizer.stopRecording()
            btnPressed = false
        }
    }
    
    //private func changeColor() {
     //   if speechRecognizer.isRecording {
     //       clr = Color(.red)
     //   }
     //   else {
           // clr = Color(.blue)
    //    }
 //   }
}


// thank you George from stackoverflow! https://stackoverflow.com/a/63289866


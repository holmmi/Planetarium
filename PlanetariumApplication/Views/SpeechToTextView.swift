//
//  TextToSpeechView.swift
//  PlanetariumApplication
//
//  Created by iosdev on 26.11.2021.
//

import SwiftUI

struct SpeechToTextView: View {
    @State private var text = ""
    let speechRecognizer = SpeechRecognizer()
    @State private var btnColor = Color(.blue)
    @State private var btnPressed: Bool = false
    @State private var clrStore: colorStore?
    
    var body: some View {
        NavigationView {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search...", text: $text)
                Button(action: initTextToSpeech) {
                    Image(systemName: "mic")
                        .foregroundColor(clrStore?.color)
                }
                
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
        }
        .onAppear() {
            clrStore = colorStore(speechRecognizer.store)
        }
    }
    
    private func initTextToSpeech() {
        print("type:", type(of: speechRecognizer.store.isRecording))
        if !btnPressed {
            speechRecognizer.record(to: $text)
        }
        else {
            speechRecognizer.stopRecording()
        }
    }
    
   
}


struct SpeechToTextView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechToTextView()
    }
}

private final class colorStore: ObservableObject {
    @State private var stateStr: SpeechRecognizer.stateStore?
    init(_ state : SpeechRecognizer.stateStore) {
        self.stateStr = state
        @State var isRecording: Bool = stateStr?.isRecording ?? false {
            didSet {
                if isRecording {
                    color = Color(.red)
                } else {
                    color = Color(.blue)
                }
            }
        }
    }
    
    @Published var color = Color(.blue)
}



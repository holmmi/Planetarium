//
//  SettingsView.swift
//  PlanetariumApplication
//
//  Created by iosdev on 7.12.2021.
//

import SwiftUI

enum Language: String, CaseIterable {
    case finnish = "fi"
    case english = "en"
}

struct SettingsView: View {
    //@StateObject var settingsModel: SettingsModel = SettingsModel()
    @AppStorage("DarkMode") var isDarkMode: Bool = false
    
    @State private var selectedLang = Language.english
    @State private var willRestart: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle("dark-mode", isOn: $isDarkMode)
                        .toggleStyle(.switch)
                }
                Section {
                    Picker("language", selection: $selectedLang) {
                        Text("finnish").tag(Language.finnish)
                        Text("english").tag(Language.english)
                    }
                    .onChange(of: selectedLang) { newValue in
                        UserDefaults.standard.set([newValue.rawValue], forKey: "AppleLanguages")
                    }
                }
                
            }
            
            
        }
        
        .navigationBarTitle("settings")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

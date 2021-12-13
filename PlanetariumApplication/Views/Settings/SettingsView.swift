//
//  SettingsView.swift
//  PlanetariumApplication
//
//  Created by Tiitus Telke on 7.12.2021.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    @AppStorage("darkMode") private var isDarkMode: Bool = false
    @AppStorage("language") private var language = Language.english
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle("dark-mode", isOn: $isDarkMode)
                        .toggleStyle(.switch)
                }
                Section(header: Text("language"), footer: Text("localization-notice")) {
                    Picker("language", selection: $language) {
                        Text("finnish")
                            .tag(Language.finnish)
                        Text("english")
                            .tag(Language.english)
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: language) { newValue in
                        settingsViewModel.changeLanguage(newValue.rawValue)
                    }
                }
            }
            .navigationBarTitle("settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor: .planetariumPrimary, titleColor: .white)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

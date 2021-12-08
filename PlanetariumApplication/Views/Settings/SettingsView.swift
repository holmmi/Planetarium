//
//  SettingsView.swift
//  PlanetariumApplication
//
//  Created by Tiitus Telke on 7.12.2021.
//

import SwiftUI

enum Language: String, CaseIterable {
    case finnish = "fi"
    case english = "en"
}

struct SettingsView: View {
    @EnvironmentObject var settingsModel: SettingsModel
    @AppStorage("DarkMode") var isDarkMode: Bool = false
    @AppStorage("i18n_language") var selectedLang: Language = Language.english
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle("dark-mode".localized(), isOn: $isDarkMode)
                        .toggleStyle(.switch)
                }
                Section(footer: Text("localization-notice".localized())) {
                    Picker("language".localized(), selection: $selectedLang) {
                        Text("finnish".localized()).tag(Language.finnish)
                        Text("english".localized()).tag(Language.english)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: selectedLang) { newValue in
                        UserDefaults.standard.set([newValue.rawValue], forKey: "AppleLanguages")
                        settingsModel.languageChanged = true
                    }
                }
            }
        }
        .navigationBarTitle("settings".localized())
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(SettingsModel())
    }
}

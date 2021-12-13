//
//  SettingsViewModel.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 13.12.2021.
//

import Foundation

class SettingsViewModel: ObservableObject {
    func changeLanguage(_ newLang: String) {
        UserDefaults.standard.set([newLang], forKey: "AppleLanguages")
    }
}

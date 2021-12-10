//
//  SettingsModel.swift
//  PlanetariumApplication
//
//  Created by Tiitus Telke on 7.12.2021.
//  Purpose of this ObservableObject is at the moment to just make all Views to update when the language is changed.
//

import Foundation
import SwiftUI

class SettingsModel: ObservableObject {
    @Published private(set) var languageChanged: Bool = false
    
    func changeLanguage(_ newLang: String) {
        UserDefaults.standard.set([newLang], forKey: "AppleLanguages")
        self.languageChanged = true
    }
}

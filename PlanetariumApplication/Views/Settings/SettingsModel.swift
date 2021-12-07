//
//  SettingsModel.swift
//  PlanetariumApplication
//
//  Created by iosdev on 7.12.2021.
//

import Foundation
import SwiftUI

class SettingsModel: ObservableObject {
    @AppStorage("AppleLanguage") var lang: String = "en"
    
    var bundle: Bundle? {
            let b = Bundle.main.path(forResource: lang, ofType: "lproj")!
            return Bundle(path: b)
        }
}

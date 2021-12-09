//
//  Extensions.swift
//  PlanetariumApplication
//
//  Created by iosdev on 8.12.2021.
//

import Foundation
import SwiftUI

extension String {
    func localized() -> String {
        @AppStorage("i18n_language") var lang: Language = Language.english
        let langStr = lang.rawValue
        
        let path = Bundle.main.path(forResource: langStr, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

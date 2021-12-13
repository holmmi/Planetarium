//
//  String.swift
//  PlanetariumApplication
//
//  Created by Tiitus Telke on 9.12.2021.
//

import SwiftUI

extension String {
    func localized() -> String {
        @AppStorage("i18n_language") var lang: Language = Language.english
        let langStr = lang.rawValue
        
        let path = Bundle.main.path(forResource: langStr, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    // partly done with this stackoverflow answer: https://stackoverflow.com/a/35700409
    func formattedDate() -> String {
        @AppStorage("i18n_language") var lang: Language = Language.english
        let langStr = lang.rawValue
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: langStr)
        dateFormatterPrint.dateStyle = .medium
        dateFormatterPrint.timeStyle = .none
        
        if let date = dateFormatterGet.date(from: self) {
            return (dateFormatterPrint.string(from: date))
        } else {
            print("There was an error decoding the string")
            return self
        }
    }
}

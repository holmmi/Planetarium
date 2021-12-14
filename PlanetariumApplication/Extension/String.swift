//
//  String.swift
//  PlanetariumApplication
//
//  Created by Tiitus Telke on 9.12.2021.
//

import SwiftUI

extension String {
    // partly done with this stackoverflow answer: https://stackoverflow.com/a/35700409
    func formattedDate() -> String {
        @AppStorage("language") var lang = Language.english
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

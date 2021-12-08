//
//  View.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 7.12.2021.
//

import SwiftUI

extension View {
    func navigationBarColor(backgroundColor: Color = .planetariumPrimary, titleColor: UIColor = .white) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }
}

//
//  NavigationBarModifier.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 7.12.2021.
//  This solution is based on https://stackoverflow.com/questions/69196530/swiftui-changing-navigation-bar-background-color-for-inline-navigationbartitledi
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    private let backgroundColor: UIColor

    init(backgroundColor: Color, titleColor: UIColor) {
        self.backgroundColor = UIColor(backgroundColor)
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear // The key is here. Change the actual bar to clear.
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
        coloredAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = titleColor
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

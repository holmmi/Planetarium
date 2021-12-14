//
//  NavigationBackButton.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 7.12.2021.
//

import SwiftUI

struct NavigationBackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: ({
            self.presentationMode.wrappedValue.dismiss()
        })) {
            Image(systemName: "chevron.backward")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
        }
    }
}

struct NavigationBackButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBackButton()
    }
}

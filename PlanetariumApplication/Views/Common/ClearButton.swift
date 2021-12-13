//
//  ClearButton.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 25.11.2021.
//

import SwiftUI

struct ClearButton: ViewModifier {
    @Binding var text: String
    var isSearching: FocusState<Bool>.Binding
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing)
        {
            content
            
            if isSearching.wrappedValue
            {
                Button(action: {
                    self.text = ""
                    isSearching.wrappedValue = false
                })
                {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
               // .padding(.trailing, 8)
            }
        }
    }
}

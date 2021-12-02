//
//  ClearButton.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 25.11.2021.
//

import SwiftUI

struct ClearButton: ViewModifier {
    @Binding var text: String
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing)
        {
            content
            
            if !text.isEmpty
            {
                Button(action: {
                    self.text = ""
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

//
//  APODSearchView.swift
//  PlanetariumApplication
//
//  Created by Tiitus Telke on 19.11.2021.
//

import SwiftUI

struct APODSearchView: View {
    @StateObject var apodSearchViewModel: APODSearchViewModel = APODSearchViewModel()
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Start Date")) {
                    DatePicker("Start Date",
                               selection: $apodSearchViewModel.startDate,
                               displayedComponents: [.date]
                    )
                }
                
                Section(header: Text("End Date")) {
                    DatePicker("End Date",
                               selection: $apodSearchViewModel.endDate,
                               displayedComponents: [.date]
                    )
                    
                }
                
                Section(header: Text("Amount of pictures")) {
                    TextField("Amount of pictures", text: $apodSearchViewModel.picAmount)
                        .keyboardType(.numberPad)
                }
                
                Section {
                    
                    NavigationLink(destination: APODSearchListView().environmentObject(apodSearchViewModel)) {
                        Text("Search")
                    }.simultaneousGesture(TapGesture().onEnded{
                        search()
                    })
                    
                    
                    
                    
                }
            }
        }
        .navigationBarTitle("Search")
    }
    
    private func search() {
        apodSearchViewModel.getPictures()
    }
    
}




struct APODSearchView_Previews: PreviewProvider {
    static var previews: some View {
        APODSearchView()
    }
}

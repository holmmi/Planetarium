//
//  APODSearchView.swift
//  PlanetariumApplication
//
//  Created by Tiitus Telke on 19.11.2021.
//

import SwiftUI

class SearchData: ObservableObject {
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var picAmount: String = ""
}

struct APODSearchView: View {
    @StateObject var searchData: SearchData = SearchData()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Start Date")) {
                    DatePicker("Start Date",
                               selection: $searchData.startDate,
                               displayedComponents: [.date]
                    )
                }
                
                Section(header: Text("End Date")) {
                    DatePicker("End Date",
                               selection: $searchData.endDate,
                               displayedComponents: [.date]
                    )
                }
                
                Section(header: Text("Random pictures")) {
                    TextField("Amount of pictures", text: $searchData.picAmount)
                        .keyboardType(.numberPad)
                }
                
                
                Section {
                    Button(action: {
                        searchData.startDate = Date()
                        searchData.endDate = Date()
                        searchData.picAmount = ""
                    }) {
                        Text("Reset")
                    }
                    NavigationLink(destination: APODSearchListView().environmentObject(searchData)) {
                        Text("Search")
                    }
                }
            }
            .navigationBarTitle("Find")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
}




struct APODSearchView_Previews: PreviewProvider {
    static var previews: some View {
        APODSearchView()
    }
}

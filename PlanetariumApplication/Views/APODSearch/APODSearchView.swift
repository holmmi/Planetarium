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
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("start-date")) {
                    DatePicker("start-date",
                               selection: $searchData.startDate,
                               displayedComponents: [.date]
                    )
                        .accessibilityIdentifier("startDate")
                }
                
                Section(header: Text("end-date")) {
                    DatePicker("end-date",
                               selection: $searchData.endDate,
                               displayedComponents: [.date]
                    )
                        .accessibilityIdentifier("endDate")
                }
                
                Section(header: Text("random-pictures")) {
                    HStack {
                        TextField("amount-of-pictures", text: $searchData.picAmount)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                            .accessibilityIdentifier("amountOfPicturesField")
                            
                        if isFocused {
                            Button(action: {
                                isFocused.toggle()
                                searchData.picAmount = ""
                            }) {
                                Text("cancel")
                            }
                            .padding(.leading, 10)
                            .accessibilityIdentifier("cancelButton")
                        }
                    }
                }

                Section {
                    Button(action: {
                        searchData.startDate = Date()
                        searchData.endDate = Date()
                        searchData.picAmount = ""
                    }) {
                        Text("reset")
                    }
                    .accessibilityIdentifier("resetButton")
                    NavigationLink(destination: APODSearchListView().environmentObject(searchData)) {
                        Text("search")
                    }
                    .accessibilityIdentifier("searchButton")
                }
                
            }
            .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        Button("done") {
                            isFocused = false
                        }
                }
            }
            .navigationBarTitle("find")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor: .planetariumPrimary, titleColor: .white)
        }
    }
}

struct APODSearchView_Previews: PreviewProvider {
    static var previews: some View {
        APODSearchView()
    }
}

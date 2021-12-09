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
    @EnvironmentObject var settingsModel: SettingsModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("start-date".localized())) {
                    DatePicker("start-date".localized(),
                               selection: $searchData.startDate,
                               displayedComponents: [.date]
                    )
                }
                
                Section(header: Text("end-date".localized())) {
                    DatePicker("end-date".localized(),
                               selection: $searchData.endDate,
                               displayedComponents: [.date]
                    )
                }
                
                Section(header: Text("random-pictures".localized())) {
                    HStack {
                        TextField("amount-of-pictures".localized(), text: $searchData.picAmount)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                            
                        if isFocused {
                            Button(action: {
                                isFocused.toggle()
                                searchData.picAmount = ""
                            }) {
                                Text("cancel".localized())
                            }
                            .padding(.leading, 10)
                            
                        }
                    }
                }

                Section {
                    Button(action: {
                        searchData.startDate = Date()
                        searchData.endDate = Date()
                        searchData.picAmount = ""
                    }) {
                        Text("reset".localized())
                    }
                    NavigationLink(destination: APODSearchListView().environmentObject(searchData)) {
                        Text("search".localized())
                    }
                }
                
            }
            .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        Button("done".localized()) {
                            isFocused = false
                        }
                }
            }
            .navigationBarTitle("find".localized())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor: .planetariumPrimary, titleColor: .white)
        }
    }
}

struct APODSearchView_Previews: PreviewProvider {
    static var previews: some View {
        APODSearchView()
            .environmentObject(SettingsModel())
    }
}

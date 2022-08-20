//
//  CountriesListView.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/30/22.
//

import SwiftUI

struct CountriesListView: View {
    @State var countries: [Country] = []
    @State private var searchText = ""
    var body: some View {
        List {
            ForEach(searchResults, id: \.name) { country in
                NavigationLink(destination: {AirlinesByCountryView(countryName: country.name)}) {
                    HStack {
                        Image(country.name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                        Text(country.name)
                            .font(.system(size: 20))
                    }
                }
            }.frame(height: 30)
        }
        .searchable(text: $searchText)
        .listStyle(PlainListStyle())
        .navigationTitle("Countries")
        .task {
            loadCountries()
        }
        .refreshable {
            await loadUtilitiesfromapi()
            loadCountries()
        }
    }
    var searchResults: [Country] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter { $0.name.contains(searchText) }
        }
    }
    func loadCountries() {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileUrl = url.appendingPathComponent("countries.plist")
        if let data = try? Data(contentsOf: fileUrl) {
            let decoder = PropertyListDecoder()
            if let response = try? decoder.decode([Country].self, from: data) {
                countries = response
                countries.sort {
                    $0.name < $1.name
                }
            } else {
                Task {
                    await loadUtilitiesfromapi()
                    loadCountries()
                }
            }
        } else {
            Task {
                await loadUtilitiesfromapi()
                loadCountries()
            }
        }
    }
}



//
//  CountriesListView.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/30/22.
//

import SwiftUI

struct CountriesListView: View {
    @State var countries: [Country] = []
    var body: some View {
        List {
            ForEach(countries, id: \.name) { country in
                NavigationLink(destination: {AirlinesByCountryView(countryName: country.name)}) {
                    Text(country.name)
                        .font(.system(size: 20))
                }
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Countries")
    }
    func loadCountries() {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileUrl = url.appendingPathComponent("airlines.plist")
        if let data = try? Data(contentsOf: fileUrl) {
            let decoder = PropertyListDecoder()
            let response = try! decoder.decode([Country].self, from: data)
            countries = response
            countries.sort {
                $0.name < $1.name
            }
        } else {
            Task {
                await loadCountriesfromapi()
                saveCountries()
                loadCountries()
            }
        }
    }
}

struct CountriesListView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesListView()
    }
}

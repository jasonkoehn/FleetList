//
//  HomeView.swift
//  Fleet List
//
//  Created by Jason Koehn on 8/7/22.
//

import SwiftUI

struct HomeView: View {
    @State var showSettingsView = false
    @State var aircraftByDate: [AircraftDate] = []
    var body: some View {
        NavigationView {
            List {
                Section("Latest Deliveries") {
                    if (aircraftByDate.count >= 5) {
                        ForEach(aircraftByDate.prefix(upTo: 5), id: \.hex) { aircraft in
                            NavigationLink(destination: AircraftView(name: aircraft.airline, country: aircraft.country, type: aircraft.type, model: aircraft.model, registration: aircraft.registration, deliverydate: aircraft.delivery, hex: aircraft.hex, msn: aircraft.msn, ln: aircraft.ln, fn: aircraft.fn, firstflight: aircraft.firstflight, productionSite: aircraft.site, config: aircraft.config, remarks: aircraft.remarks)) {
                                HStack {
                                    Image(aircraft.airline)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50)
                                    HStack {
                                        Text(aircraft.registration)
                                            .font(.system(size: 23))
                                            .padding(0)
                                        Spacer()
                                    }.frame(width: 100)
                                    VStack(alignment: .leading) {
                                        Text(aircraft.model)
                                            .font(.system(size: 15))
                                            .padding(0)
                                        Text(aircraft.delivery)
                                            .font(.system(size: 15))
                                            .padding(0)
                                    }
                                }
                            }.listRowBackground(Color("DarkGreen"))
                        }
                    }
                }
                Section("Fleets") {
                    NavigationLink(destination: AirlineListView()) {
                        Text("Airline List")
                            .foregroundColor(.black)
                            .font(.system(size: 27))
                            .bold()
                            .padding(4)
                    }
                    .listRowBackground(Color(.systemTeal))
                    NavigationLink(destination: CountriesListView()) {
                        Text("Airline By Country")
                            .foregroundColor(.black)
                            .font(.system(size: 27))
                            .bold()
                            .padding(4)
                    }
                    .listRowBackground(Color(.systemOrange))
                }
                Section("Interesting Facts") {
                    NavigationLink(destination: BoeingCustomerCodesView()) {
                        Text("Boeing Customer Codes")
                            .foregroundColor(.black)
                            .font(.system(size: 25))
                    }.listRowBackground(Color(.systemBlue))
                }
            }
            .listStyle(GroupedListStyle())
            .task {
                loadAircraft()
            }
            .navigationTitle("Fleet List")
            .navigationBarItems(trailing: Button(action: {
                self.showSettingsView.toggle()
            }) {
                Image(systemName: "gear")
                    .frame(width: 30, height: 30)
            })
            .sheet(isPresented: $showSettingsView) {
                NavigationView {
                    SettingsView()
                }
            }
            .refreshable {
                Task {
                    await loadAirlinesfromapi()
                    saveAirlines()
                    await loadAircraftfromapi()
                    saveAircraft()
                    loadAircraft()
                    await loadUtilitiesfromapi()
                }
            }
        }
    }
    func loadAircraft() {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileUrl = url.appendingPathComponent("aircraft.plist")
        if let data = try? Data(contentsOf: fileUrl) {
            let decoder = PropertyListDecoder()
            if let response = try? decoder.decode([Aircraft].self, from: data) {
                aircraftByDate = []
                for aircraft in response {
                    let fmt = DateFormatter()
                    fmt.locale = Locale(identifier: "en_US_POSIX")
                    fmt.dateFormat = "MMM d, yyyy"
                    
                    let dt = fmt.date(from: aircraft.delivery)!
                    
                    fmt.dateFormat = "yyyy-MM-dd"
                    let decodedDate = fmt.string(from: dt)
                    aircraftByDate.append(AircraftDate(airline: aircraft.airline, type: aircraft.type, model: aircraft.model, registration: aircraft.registration, country: aircraft.country, firstflight: aircraft.firstflight, delivery: aircraft.delivery, hex: aircraft.hex, config: aircraft.config, msn: aircraft.msn, ln: aircraft.ln, fn: aircraft.fn, site: aircraft.site, remarks: aircraft.remarks, sortDate: decodedDate))
                }
                aircraftByDate.sort {
                    $0.sortDate > $1.sortDate
                }
            } else {
                Task {
                    await loadAircraftfromapi()
                    saveAircraft()
                    loadAircraft()
                }
            }
        } else {
            Task {
                await loadAircraftfromapi()
                saveAircraft()
                loadAircraft()
            }
        }
    }
}


//
//  HomeView.swift
//  Fleet List
//
//  Created by Jason Koehn on 8/7/22.
//

import SwiftUI

struct HomeView: View {
    @State var showSettingsView = false
    @State var aircraft: [Aircraft] = []
    var body: some View {
        NavigationView {
            List {
                Section("Latest Deliveries") {
                    if (aircraft.count >= 5) {
                        ForEach(aircraft.prefix(upTo: 5), id: \.hex) { aircraft in
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
                                            .foregroundColor(.black)
                                        Spacer()
                                    }.frame(width: 100)
                                    VStack(alignment: .leading) {
                                        Text(aircraft.model)
                                            .font(.system(size: 15))
                                            .padding(0)
                                            .foregroundColor(.black)
                                        Text(aircraft.delivery)
                                            .font(.system(size: 15))
                                            .padding(0)
                                            .foregroundColor(.black)
                                    }
                                }
                            }.listRowBackground(Color(.systemOrange))
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
                    .listRowBackground(Color(.systemIndigo))
                }
                Section("Interesting Facts") {
                    NavigationLink(destination: BoeingCustomerCodesView()) {
                        Text("Boeing Customer Codes")
                            .foregroundColor(.black)
                            .font(.system(size: 25))
                    }.listRowBackground(Color.blue)
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
        }
    }
    func loadAircraft() {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileUrl = url.appendingPathComponent("aircraft.plist")
        if let data = try? Data(contentsOf: fileUrl) {
            let decoder = PropertyListDecoder()
            if let response = try? decoder.decode([Aircraft].self, from: data) {
                aircraft = response
                aircraft.sort {
                    $0.delivery > $1.delivery
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

struct RowView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(.systemGray6))
                .cornerRadius(12)
                .padding(3)
            HStack {
                Spacer()
                NavigationLink(destination: AirlineListView()) {
                    Text("Airlines")
                        .font(.system(size: 25))
                        .bold()
                        .foregroundColor(.black)
                        .frame(width: 150, height: 80)
                        .background(Color(.systemCyan))
                        .cornerRadius(8)
                }
                Spacer()
                NavigationLink(destination: CountriesListView()) {
                    Text("By Country")
                        .font(.system(size: 25))
                        .bold()
                        .foregroundColor(.black)
                        .frame(width: 150, height: 80)
                        .background(Color(.systemGreen))
                        .cornerRadius(8)
                }
                Spacer()
            }
        }
        .frame(maxWidth: 500, maxHeight: 120)
        .background(Color(.systemGreen))
        .cornerRadius(15)
        .padding(.horizontal, 15)
        .shadow(radius: 1)
        
    }
}

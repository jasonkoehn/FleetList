//
//  AircraftView.swift
//  Fleet List
//
//  Created by Jason Koehn on 6/29/22.
//

import SwiftUI

struct AircraftView: View {
    var name: String//
    var type: String//
    var model: String//
    var registration: String//
    var deliverydate: String//
    var hex: String//
    var msn: Int//
    var ln: Int//
    var fn: Int//
    var firstflight: String//
    var productionSite: String
    var config: String
    @State var productionAirport = ""
    @State var productionCountry = ""
    @State var decodedDate = ""
    @State var decodedFirstFlight = ""
    @State var years = 0
    @State var months = 0
    var body: some View {
        VStack {
            Text(registration)
                .font(.system(size: 60))
                .padding(1)
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(4)
                .frame(height: 60)
                .padding(.bottom, 5)
            HStack {
                Spacer()
                Text(model)
                    .font(.system(size: 30))
                Text("("+type+")")
                    .font(.system(size: 20))
                    .italic()
                Spacer()
            }.padding(.bottom, 5)
            VStack {
                HStack {
                    Text("Hex:")
                        .font(.system(size: 20))
                        .italic()
                    Text(hex)
                        .font(.system(size: 25))
                }.padding(.top, 1)
                Divider()
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Text("First Flight:")
                            .font(.system(size: 20))
                            .italic()
                        Spacer()
                        Text(decodedFirstFlight)
                            .font(.system(size: 20))
                        Spacer()
                    }
                    Spacer()
                    VStack {
                        Spacer()
                        Text("Delivery:")
                            .font(.system(size: 20))
                            .italic()
                        Spacer()
                        Text(decodedDate)
                            .font(.system(size: 20))
                        Spacer()
                    }
                    Spacer()
                }.frame(height: 60)
                Divider()
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Text("MSN")
                            .font(.system(size: 20))
                            .italic()
                        Spacer()
                        Text(verbatim: "\(msn)")
                            .font(.system(size: 20))
                        Spacer()
                    }
                    if ln != 0 {
                        Spacer()
                        VStack {
                            Spacer()
                            Text("LN")
                                .font(.system(size: 20))
                                .italic()
                            Spacer()
                            Text(verbatim: "\(ln)")
                                .font(.system(size: 20))
                            Spacer()
                        }
                    }
                    Spacer()
                    VStack {
                        Spacer()
                        Text("FN")
                            .font(.system(size: 20))
                            .italic()
                        Spacer()
                        Text(verbatim: "\(fn)")
                            .font(.system(size: 20))
                        Spacer()
                    }
                    Spacer()
                }.frame(height: 60)
            }
            VStack {
                Divider()
                VStack {
                    Spacer()
                    HStack {
                        Text("Config:")
                            .font(.system(size: 20))
                            .italic()
                        Text(config)
                            .font(.system(size: 20))
                    }
                    Spacer()
                    HStack {
                        Image(productionCountry)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 23)
                        Text(productionAirport+"("+productionSite+")")
                            .font(.system(size: 20))
                    }
                    Spacer()
                }.frame(height: 60)
                Divider()
            }
            Spacer()
        }
        .task {
            productionList()
            convertDate()
            convertToTime()
        }
    }
    func productionList() {
        switch productionSite {
        case "RNT":
            productionAirport = "Renton"
            productionCountry = "United States"
            
        case "BFM":
            productionAirport = "Mobile"
            productionCountry = "United States"
            
        case "SJK":
            productionAirport = "Sao Jose Dos Campos"
            productionCountry = "Brazil"
            
        default:
            productionAirport = ""
            productionCountry = ""
        }
    }
    func convertDate() {
        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "en_US_POSIX")
        fmt.dateFormat = "yyyy-MM-dd"
        
        let dt = fmt.date(from: deliverydate)!
        
        fmt.dateFormat = "MMM d, yyyy"
        decodedDate = fmt.string(from: dt)
    }
    func convertToTime() {
        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "en_US_POSIX")
        fmt.dateFormat = "yyyy-MM-dd"
        
        let dt = fmt.date(from: firstflight)!
        let tdt = Date()
        
        fmt.dateFormat = "MMM d, yyyy"
        decodedFirstFlight = fmt.string(from: dt)
        
        let diffs = Calendar.current.dateComponents([.year, .month, .day], from: dt, to: tdt)
        years = diffs.year!
        months = diffs.month!
    }
}

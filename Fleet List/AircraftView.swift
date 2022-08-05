//
//  AircraftView.swift
//  Fleet List
//
//  Created by Jason Koehn on 6/29/22.
//

import SwiftUI

struct AircraftView: View {
    var name: String
    var country: String
    var type: String
    var model: String
    var registration: String
    var deliverydate: String
    var hex: String
    var msn: String
    var ln: String
    var fn: String
    var firstflight: String
    var productionSite: String
    var config: String
    var remarks: String
    @State var productionAirport = ""
    @State var productionCountry = ""
    @State var years: Int = 0
    @State var yearsFraction: Double = 0.0
    @State var isYearFraction: Bool = true
    var body: some View {
        VStack {
            Text(registration)
                .font(.system(size: 60))
                .padding(1)
                .padding(.top, 50)
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
                Divider()
                VStack {
                    Spacer()
                    HStack {
                        Text("Hex:")
                            .font(.system(size: 23))
                            .italic()
                        Text(hex)
                            .font(.system(size: 25))
                    }
                    Spacer()
                    HStack {
                        Text("Country Of Reg:")
                            .font(.system(size: 20))
                            .italic()
                        Image(country)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 23)
                    }
                    Spacer()
                }.frame(height: 60)
                Divider()
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Text("First Flight:")
                            .font(.system(size: 20))
                            .italic()
                        Spacer()
                        Text(firstflight)
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
                        Text(deliverydate)
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
                        Text(msn)
                            .font(.system(size: 20))
                        Spacer()
                    }
                    if ln != "0" {
                        Spacer()
                        VStack {
                            Spacer()
                            Text("LN")
                                .font(.system(size: 20))
                                .italic()
                            Spacer()
                            Text(ln)
                                .font(.system(size: 20))
                            Spacer()
                        }
                    }
                    if fn != "0" {
                        Spacer()
                        VStack {
                            Spacer()
                            Text("FN")
                                .font(.system(size: 20))
                                .italic()
                            Spacer()
                            Text(fn)
                                .font(.system(size: 20))
                            Spacer()
                        }
                    }
                    Spacer()
                }.frame(height: 60)
            }
            VStack {
                Divider()
                VStack {
                    Spacer()
                    HStack {
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
                            Text("Age:")
                                .font(.system(size: 20))
                                .italic()
                            if isYearFraction == false {
                                switch years {
                                case 0:
                                    Text("Brand New")
                                        .font(.system(size: 20))
                                case 1:
                                    HStack(spacing: 2) {
                                        Text("\(years)")
                                            .font(.system(size: 20))
                                        Text("year")
                                            .font(.system(size: 17))
                                            .italic()
                                    }
                                default:
                                    HStack(spacing:2) {
                                        Text("\(years)")
                                            .font(.system(size: 20))
                                        Text("years")
                                            .font(.system(size: 17))
                                            .italic()
                                    }
                                }
                            } else {
                                switch yearsFraction {
                                case 0.0 ... 0.9:
                                    Text("Brand New")
                                        .font(.system(size: 20))
                                case 1.0:
                                    HStack(spacing: 2) {
                                        Text("\(yearsFraction, specifier: "%.1f")")
                                            .font(.system(size: 20))
                                        Text("year")
                                            .font(.system(size: 17))
                                            .italic()
                                    }
                                default:
                                    HStack(spacing: 2) {
                                        Text("\(yearsFraction, specifier: "%.1f")")
                                            .font(.system(size: 20))
                                        Text("years")
                                            .font(.system(size: 17))
                                            .italic()
                                    }
                                }
                            }
                        }
                        Spacer()
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
                if remarks != "" {
                    HStack {
                        Text("Remarks:")
                            .font(.system(size: 20))
                            .italic()
                        Text(remarks)
                            .font(.system(size: 18))
                    }
                }
            }
            Spacer()
        }
        .textSelection(.enabled)
        .task {
            productionList()
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
            
        case "CHS":
            productionAirport = "Charleston"
            productionCountry = "United States"
            
        default:
            productionAirport = ""
            productionCountry = ""
        }
    }
    func convertToTime() {
        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "en_US_POSIX")
        if firstflight.count == 4 {
            fmt.dateFormat = "yyyy"
            let dt = fmt.date(from: firstflight)!
            let tdt = Date()
            let diffs = Calendar.current.dateComponents([.year], from: dt, to: tdt)
            isYearFraction = false
            years = diffs.year!
        } else if firstflight.count == 8 {
            fmt.dateFormat = "MMM yyyy"
            let dt = fmt.date(from: firstflight)!
            let tdt = Date()
            let diffs = Calendar.current.dateComponents([.year, .month], from: dt, to: tdt)
            yearsFraction = Double(diffs.year!) + (Double(diffs.month!) / 12)
        } else {
            fmt.dateFormat = "MMM d, yyyy"
            let dt = fmt.date(from: firstflight)!
            let tdt = Date()
            let diffs = Calendar.current.dateComponents([.year, .month], from: dt, to: tdt)
            yearsFraction = Double(diffs.year!) + (Double(diffs.month!) / 12)
        }
    }
}

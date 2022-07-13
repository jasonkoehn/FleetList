//
//  AircraftView.swift
//  Fleet List
//
//  Created by Jason Koehn on 6/29/22.
//

import SwiftUI

struct AircraftView: View {
    var name: String
    var alias: String
    var type: String
    var model: String
    var registration: String
    var delivery_date: String
    var hex: String
    var msn: Int
    var ln: Int
    var fn: Int
    var body: some View {
        VStack {
            Image(alias)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal)
                .frame(height: 100)
            Text(registration)
                .font(.system(size: 50))
                .padding(15)
            Text(model)
                .font(.system(size: 35))
                .padding(.bottom)
            List {
                HStack {
                    HStack {
                        Text("Operator:")
                            .font(.system(size: 25))
                            .italic()
                        Spacer()
                    }
                    .frame(width: 115)
                    Text(name)
                        .font(.system(size: 25))
                    Spacer()
                }
                HStack {
                    HStack {
                        Text("Type:")
                            .font(.system(size: 25))
                            .italic()
                        Spacer()
                    }
                    .frame(width: 115)
                    Text(type)
                        .font(.system(size: 25))
                    Spacer()
                }
                HStack {
                    HStack {
                        Text("Delivery:")
                            .font(.system(size: 25))
                            .italic()
                        Spacer()
                    }
                    .frame(width: 115)
                    Text(delivery_date)
                        .font(.system(size: 25))
                    Spacer()
                }
                HStack {
                    HStack {
                        Text("Hex:")
                            .font(.system(size: 25))
                            .italic()
                        Spacer()
                    }
                    .frame(width: 115)
                    Text(hex)
                        .font(.system(size: 25))
                    Spacer()
                }
                HStack {
                    HStack {
                        Text("MSN:")
                            .font(.system(size: 25))
                            .italic()
                        Spacer()
                    }
                    .frame(width: 115)
                    Text(verbatim: "\(msn)")
                    
                        .font(.system(size: 25))
                    Spacer()
                }
                if ln != 0 {
                    HStack {
                        HStack {
                            Text("LN:")
                                .font(.system(size: 25))
                                .italic()
                            Spacer()
                        }
                        .frame(width: 115)
                        Text(verbatim: "\(ln)")
                            .font(.system(size: 25))
                        Spacer()
                    }
                }
                HStack {
                    HStack {
                        Text("FN:")
                            .font(.system(size: 25))
                            .italic()
                        Spacer()
                    }
                    .frame(width: 115)
                    Text(verbatim: "\(fn)")
                        .font(.system(size: 25))
                    Spacer()
                }
            }
            .listStyle(PlainListStyle())
            .disabled(true)
            Spacer()
        }
    }
}

struct AircraftView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftView(name: "Southwest Airlines", alias: "SouthwestAirlines", type: "B38M", model: "Boeing 737 MAX 8", registration: "N8707P", delivery_date: "2017-09-25", hex: "ABF9B1", msn: 36929, ln: 5992, fn: 8707)
    }
}

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
                    Text("Operator:")
                        .font(.system(size: 25))
                        .italic()
                        .frame(width: 110)
                    Text(name)
                        .font(.system(size: 25))
                    Spacer()
                }
                HStack {
                    Text("Type:")
                        .font(.system(size: 25))
                        .italic()
                        .frame(width: 110)
                    Text(type)
                        .font(.system(size: 25))
                    Spacer()
                }
                HStack {
                    Text("Delivery:")
                        .font(.system(size: 25))
                        .italic()
                        .frame(width: 110)
                    Text(delivery_date)
                        .font(.system(size: 25))
                    Spacer()
                }
                HStack {
                    Text("Hex:")
                        .font(.system(size: 25))
                        .italic()
                        .frame(width: 110)
                    Text(hex)
                        .font(.system(size: 25))
                    Spacer()
                }
                HStack {
                    Text("MSN:")
                        .font(.system(size: 25))
                        .italic()
                        .frame(width: 110)
                    Text(verbatim: "\(msn)")
                    
                        .font(.system(size: 25))
                    Spacer()
                }
                if ln != 0 {
                    HStack {
                        Text("LN:")
                            .font(.system(size: 25))
                            .italic()
                            .frame(width: 110)
                        Text(verbatim: "\(ln)")
                            .font(.system(size: 25))
                        Spacer()
                    }
                }
                HStack {
                    Text("FN:")
                        .font(.system(size: 25))
                        .italic()
                        .frame(width: 110)
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


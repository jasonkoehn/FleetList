//
//  HomeView.swift
//  Fleet List
//
//  Created by Jason Koehn on 8/7/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Fleet List")
                .font(.system(size: 40))
                .italic()
                .bold()
                .padding(1)
                .padding(.top, 15)
            Spacer()
            Divider()
            NavigationLink(destination: AirlineListView()) {
                HStack {
                    Text("Airlines")
                        .font(.system(size: 27))
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                .frame(width: 400, height: 25)
            }
            Divider()
            NavigationLink(destination: CountriesListView()) {
                HStack {
                    Text("Listed By Country")
                        .font(.system(size: 27))
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                .frame(width: 400, height: 25)
            }
            Divider()
            Spacer()
        }
    }
}


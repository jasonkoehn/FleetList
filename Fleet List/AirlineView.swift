//
//  AirlineView.swift
//  Fleet List
//
//  Created by Jason Koehn on 6/29/22.
//

import SwiftUI

struct AirlineView: View {
    @State private var airlines = [Airlines]()
    var body: some View {
        NavigationView {
            List {
                ForEach(airlines, id: \.name) { airlines in
                    NavigationLink(destination: {FleetView(airlineurl: airlines.data_url)}) {
                        HStack {
                            Image(airlines.name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
        
                        }
                    }
                }
            }
            .task {
                await loadData()
            }
            
        }
    }
    func loadData() async {
        guard let url = URL(string: "https://jasonkoehn.github.io/AirlineData/Airlines.json") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(AirlinesJSON.self, from: data) {
                airlines = decodedResponse.airlines
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct AirlinesJSON: Codable {
    var airlines: [Airlines]
}

struct Airlines: Codable {
    var name: String
    var data_url: String
}

struct AirlineView_Previews: PreviewProvider {
    static var previews: some View {
        AirlineView()
    }
}

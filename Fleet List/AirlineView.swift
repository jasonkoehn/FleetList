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
                            AsyncImage(url: URL(string: "jasonkoehn.github.io/AirlineData/SouthwestAirlines.png")) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                default:
                                    VStack {
                                        Image(systemName: "books.vertical")
                                            .font(.largeTitle)
                                            .padding(95)
                                    }
                                    .frame(width: 40, height: 40)
                                    .background(Color.gray.opacity(0.5))
                                }
                            }
                            //                            Image(airlines.name)
                            //                                .resizable()
                            //                                .frame(width: 40, height: 40)
                            //                                .cornerRadius(3)
                            Text(airlines.name)
                                .font(.system(size: 25))
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
    var picture_url: String
    var square_url: String
}

struct AirlineView_Previews: PreviewProvider {
    static var previews: some View {
        AirlineView()
    }
}

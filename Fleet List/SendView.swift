//
//  SendView.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/18/22.
//

import SwiftUI

//struct SendView: View {
//    @State var aircraft: [Aircraft] = [Aircraft(type: "B38M", model: "Boeing 737 Max", registration: "N8801Q", delivery_date: "2019-12-21", hex: "A1CDBO", msn: 44832, ln: 4455, fn: 8801)]
//    var body: some View {
//        Button("Place Order") {
//            Task {
//                await placeOrder()
//            }
//        }
//    }
//    func placeOrder() async {
//        guard let encoded = try? JSONEncoder().encode(aircraft) else {
//            print("Failed to encode order")
//            return
//        }
//        let url = URL(string: "https://jasonkoehn.github.io/AirlineData/ABC.json")!
//        var request = URLRequest(url: url)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//        do {
//            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
//            // handle the result
//        } catch {
//            print("Checkout failed.")
//        }
//    }
//}
//
//struct SendView_Previews: PreviewProvider {
//    static var previews: some View {
//        SendView()
//    }
//}

//
//  BoeingCustomerCodesView.swift
//  Fleet List
//
//  Created by Jason Koehn on 8/9/22.
//

import SwiftUI

struct BoeingCustomerCodesView: View {
    var body: some View {
        Text("Boeing Customer Codes")
            .navigationBarTitle("Boeing Customer Codes", displayMode: .inline)
    }
}

struct BoeingCustomerCodesView_Previews: PreviewProvider {
    static var previews: some View {
        BoeingCustomerCodesView()
    }
}

struct BoeingCustomerCodes: Codable {
    var code: String
    var customer: String
    var aircraft: String
}

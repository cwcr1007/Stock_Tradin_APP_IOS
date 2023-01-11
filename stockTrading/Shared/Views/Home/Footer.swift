//
//  Footer.swift
//  stockTrading (iOS)
//
//  Created by Bob Dai on 4/10/22.
//

import SwiftUI

struct Footer: View {
    var body: some View {
        HStack {
            Spacer()
            Link("Powered by Finnhub.io", destination: URL(string: "https://www.finnhub.io")!)
                .font(.footnote)
                .foregroundColor(.gray)
                .background(.white)
            Spacer()
        }
    }
}

struct Footer_Previews: PreviewProvider {
    static var previews: some View {
        Footer()
    }
}

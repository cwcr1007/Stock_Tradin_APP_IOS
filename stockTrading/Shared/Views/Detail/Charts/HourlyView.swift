//
//  HourlyView.swift
//  stockTrading
//
//  Created by Bob Dai on 4/18/22.
//

import SwiftUI

struct HourlyView: View {
    @State var title: String = ""
    @State var error: Error? = nil
    
    var ticker: String
    var priceChange: Double
    var endTime: Int
    
    var body: some View {
        WebView(title: $title, fileName: "hourlyChart", ticker: ticker, priceChange: priceChange, endTime: endTime)
            .onLoadStatusChanged { loading, error in
                if loading {
//                        print("Loading started")
                    self.title = " "
                }
                else {
//                        print("Done loading.")
                    if let error = error {
                        self.error = error
                        if self.title.isEmpty {
                            self.title = "Error"
                        }
                    }
                    else if self.title.isEmpty {
                        self.title = " "
                    }
                }
            }
            .navigationBarTitle(title)
    }
}

struct HourlyView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView(ticker: "TSLA", priceChange: 1, endTime: 1650397963)
    }
}

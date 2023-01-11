//
//  TrendView.swift
//  stockTrading
//
//  Created by Bob Dai on 4/20/22.
//

import SwiftUI

struct TrendView: View {
    @State var title: String = ""
    @State var error: Error? = nil
    var ticker: String
    
    var body: some View {
        WebView(title: $title, fileName: "trendChart", ticker: ticker, priceChange: 0, endTime: 0)
            .onLoadStatusChanged { loading, error in
                if loading {
//                    print("Loading started")
                    self.title = " "
                }
                else {
//                    print("Done loading.")
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

struct TrendView_Previews: PreviewProvider {
    static var previews: some View {
        TrendView(ticker: "T")
    }
}

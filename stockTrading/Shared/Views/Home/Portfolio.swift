//
//  Portfolio.swift
//  stockTrading (iOS)
//
//  Created by Bob Dai on 4/10/22.
//

import SwiftUI

struct Portfolio: View {
    @EnvironmentObject var detailVM: DetailVM
    @AppStorage("balance") var balance: Double = 25000
    @AppStorage("portfolio") var portfolio: [StoredType] = []
    @ObservedObject var priceVM: PriceVM
    @AppStorage("stockValue") var stockValue: Double = 0
    
    let timer = Timer.publish(every: 15.0, on: .main, in: .common).autoconnect()
    
    func move(from source: IndexSet, to destination: Int) {
        portfolio.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
        VStack {
            HStack{
                VStack(alignment: .leading){
                    Text("Net Worth")
                    Text("$\(stockValue + 25000, specifier: "%.2f")")
                        .fontWeight(.bold)
                }
                Spacer()
                VStack{
                    Text("Cash Balance")
                    Text("$\(balance, specifier: "%.2f")")
                        .fontWeight(.bold)
                }
            }
            .font(.title2)
        }
        .onAppear{
            priceVM.fetchAll(portfolio)
            print("appear")
        }
        .onReceive(timer) { time in
            print("The time is now \(time)")
            priceVM.fetchAll(portfolio)
        }
        
        ForEach(portfolio, id: \.ticker) { item in
            PortfolioRow(item: item)
                .environmentObject(priceVM)
        }
        .onMove(perform: move)
    }
}

//
//  FavoriteRow.swift
//  stockTrading
//
//  Created by Bob Dai on 5/2/22.
//

import SwiftUI

struct FavoriteRow: View {
    @EnvironmentObject var detailVM: DetailVM
    var item: StoredType!
    let timer = Timer.publish(every: 15.0, on: .main, in: .common).autoconnect()
    @ObservedObject var priceVM = PriceVM()
    
    var body: some View {
        NavigationLink {
            StockDetail(ticker: item.ticker)
                .environmentObject(detailVM)
        } label: {
            VStack(alignment: .leading) {
                HStack{
                    Text(item.ticker)
                        .fontWeight(.bold)
                        .font(.title3)
                    Spacer()
                    if priceVM.price == nil{
                        Text("$\(item.totalPrice, specifier: "%.2f")")
                            .fontWeight(.bold)
                    }else{
                        Text("$\(priceVM.price!.c, specifier: "%.2f")")
                            .fontWeight(.bold)
                    }
                    
                }

                HStack{
                    Text(item.name)
                        .foregroundColor(.gray)
                    Spacer()
                    if priceVM.price == nil{
                        if item.change > 0 {
                            Image(systemName: "arrow.up.right")
                                .foregroundColor(.green)
                            Text("\(item.change, specifier: "%.2f") (\(item.changePercentage, specifier: "%.2f")%)")
                                .foregroundColor(.green)
                        }else if item.change < 0 {
                            Image(systemName: "arrow.down.forward")
                                .foregroundColor(.red)
                            Text("\(item.change, specifier: "%.2f") (\(item.changePercentage, specifier: "%.2f")%)")
                                .foregroundColor(.red)
                        }else{
                            Image(systemName: "minus")
                                .foregroundColor(.gray)
                            Text("\(item.change, specifier: "%.2f") (\(item.changePercentage, specifier: "%.2f")%)")
                                .foregroundColor(.gray)
                        }
                    }else{
                        if priceVM.price!.d > 0 {
                            Image(systemName: "arrow.up.right")
                                .foregroundColor(.green)
                            Text("\(priceVM.price!.d, specifier: "%.2f") (\(priceVM.price!.dp, specifier: "%.2f")%)")
                                .foregroundColor(.green)
                        }else if priceVM.price!.d < 0 {
                            Image(systemName: "arrow.down.forward")
                                .foregroundColor(.red)
                            Text("\(priceVM.price!.d, specifier: "%.2f") (\(priceVM.price!.dp, specifier: "%.2f")%)")
                                .foregroundColor(.red)
                        }else{
                            Image(systemName: "minus")
                                .foregroundColor(.gray)
                            Text("\(priceVM.price!.d, specifier: "%.2f") (\(priceVM.price!.dp, specifier: "%.2f")%)")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .onAppear{
            priceVM.fetchPrice(item.ticker)
        }
        .onReceive(timer) { time in
//            print("The time is now \(time)")
            priceVM.fetchPrice(item.ticker)
        }
    }
}

struct FavoriteRow_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteRow()
    }
}

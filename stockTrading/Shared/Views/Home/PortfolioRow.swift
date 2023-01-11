//
//  PortfolioRow.swift
//  stockTrading
//
//  Created by Bob Dai on 5/3/22.
//

import SwiftUI
import Alamofire

struct PortfolioRow: View {
    var item: StoredType!
    @EnvironmentObject var priceVM: PriceVM
    @AppStorage("portfolio") var portfolio: [StoredType] = []
    @EnvironmentObject var detailVM: DetailVM

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
                    if priceVM.allPrice[item.ticker] == nil{
                        Text("$\(item.totalPrice, specifier: "%.2f")")
                            .fontWeight(.bold)
                    }else{
                        Text("$\(priceVM.allPrice[item.ticker]!.c * Double(item.share), specifier: "%.2f")")
                            .fontWeight(.bold)
                    }
                }
                HStack{
                    if item.share > 1{
                        Text("\(item.share) shares")
                            .foregroundColor(.gray)
                    }else{
                        Text("\(item.share) share")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    if priceVM.allPrice[item.ticker] == nil{
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
                        if priceVM.allPrice[item.ticker]!.c * Double(item.share) > item.totalPrice {
                            Image(systemName: "arrow.up.right")
                                .foregroundColor(.green)
                            Text("\(priceVM.allPrice[item.ticker]!.c * Double(item.share) - item.totalPrice, specifier: "%.2f") (\((priceVM.allPrice[item.ticker]!.c * Double(item.share) - item.totalPrice) / item.totalPrice * 100, specifier: "%.2f")%)")
                                .foregroundColor(.green)
                        }else if priceVM.allPrice[item.ticker]!.c * Double(item.share) < item.totalPrice {
                            Image(systemName: "arrow.down.forward")
                                .foregroundColor(.red)
                            Text("\(priceVM.allPrice[item.ticker]!.c * Double(item.share) - item.totalPrice, specifier: "%.2f") (\((priceVM.allPrice[item.ticker]!.c * Double(item.share) - item.totalPrice) / item.totalPrice * 100, specifier: "%.2f")%)")
                                .foregroundColor(.red)
                        }else{
                            Image(systemName: "minus")
                                .foregroundColor(.gray)
                            Text("\(priceVM.allPrice[item.ticker]!.c * Double(item.share) - item.totalPrice, specifier: "%.2f") (\((priceVM.allPrice[item.ticker]!.c * Double(item.share) - item.totalPrice) / item.totalPrice * 100, specifier: "%.2f")%)")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
    }
}

//
//  PortfolioSection.swift
//  stockTrading
//
//  Created by Bob Dai on 4/19/22.
//

import SwiftUI

struct PortfolioSection: View {
    var ticker: String!
    @State private var showingSheet = false
    @EnvironmentObject var detailVM: DetailVM
    @AppStorage("portfolio") var portfolio: [StoredType] = []
        
    var body: some View {
        VStack{
            HStack {
                Text("Portfolio")
                    .font(.title2)
                Spacer()
            }
            HStack{
                VStack(alignment: .leading){
                    if portfolio.contains(where: {$0.ticker == ticker}) {
                        let item = portfolio.filter({$0.ticker == ticker}).first
                        HStack {
                            Text("Shares Owned: ")
                                .fontWeight(.bold)
                            Text("\(item!.share)")
                        }
                        .padding(.bottom, 1)
                        
                        HStack {
                            Text("Avg. Cost / Share: ")
                                .fontWeight(.bold)
                            Text("$\(Double(item!.totalPrice)/Double(item!.share), specifier: "%.2f")")
                        }
                        .padding(.bottom, 1)
                        
                        HStack {
                            Text("Total Cost: ")
                                .fontWeight(.bold)
                            Text("$\(Double(item!.totalPrice), specifier: "%.2f")")
                        }
                        .padding(.bottom, 1)
                        
//                        let change = detailVM.price!.c - Double(item!.totalPrice)/Double(item!.share)
                        HStack {
                            Text("Change: ")
                                .fontWeight(.bold)
                            if detailVM.price!.c - Double(item!.totalPrice)/Double(item!.share) > 0{
                                Text("$\(detailVM.price!.c - Double(item!.totalPrice)/Double(item!.share), specifier: "%.2f")")
                                    .foregroundColor(.green)
                            }else if detailVM.price!.c - Double(item!.totalPrice)/Double(item!.share) < 0{
                                Text("$\(detailVM.price!.c - Double(item!.totalPrice)/Double(item!.share), specifier: "%.2f")")
                                    .foregroundColor(.red)
                            }else{
                                Text("$\(detailVM.price!.c - Double(item!.totalPrice)/Double(item!.share), specifier: "%.2f")")
                            }
                        }
                        .padding(.bottom, 1)
                        
                        HStack {
                            Text("Market Value: ")
                                .fontWeight(.bold)
                            
                            if detailVM.price!.c - Double(item!.totalPrice)/Double(item!.share) > 0{
                                Text("$\(Double(item!.share) * detailVM.price!.c, specifier: "%.2f")")
                                    .foregroundColor(.green)
                            }else if detailVM.price!.c - Double(item!.totalPrice)/Double(item!.share) < 0{
                                Text("$\(Double(item!.share) * detailVM.price!.c, specifier: "%.2f")")
                                    .foregroundColor(.red)
                            }else{
                                Text("$\(Double(item!.share) * detailVM.price!.c, specifier: "%.2f")")
                            }
                        }
                        .padding(.bottom)

                    }else{
                        Text("You have 0 shares of \(ticker).")
                            .padding(.bottom, 1)
                        Text("Start trading!")
                            .padding(.bottom)
                    }
                }
                .font(.footnote)
                
                Spacer()
                
                Button {
                    showingSheet.toggle()
                } label: {
                    Text("Trade")
                        .frame(minWidth: 0, maxWidth: 100)
                        .padding()
                        .foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(40)
                }
                .sheet(isPresented: $showingSheet) {
                    TradeSheet()
                }
            }
        }
        .padding([.leading, .trailing])
    }
}

struct PortfolioSection_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioSection(ticker: "TSLA")
            .environmentObject(DetailVM())
    }
}

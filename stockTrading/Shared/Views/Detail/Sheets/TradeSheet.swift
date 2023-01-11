//
//  TradeSheet.swift
//  stockTrading
//
//  Created by Bob Dai on 4/24/22.
//

import SwiftUI

struct TradeSheet: View {
    @AppStorage("balance") var balance: Double = 25000
    @AppStorage("portfolio") var portfolio: [StoredType] = []
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var detailVM: DetailVM
    
    @State var showToast: Bool = false
    @State var toastText: String = ""
    
    @State private var input = ""
    @State private var showingSheet = false
    
    @State var theInput: String!
    @State var ticker: String!
    @State var action: String!
    
    var body: some View {
        if showingSheet {
            ZStack {
                Color.green
                    .ignoresSafeArea() // 1
                VStack{
                    Spacer()
                    Text("Congratulations!")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding()
                    if input == "1" {
                        Text("You have successfully \(action) \(input) shares of \(ticker)")
                            .foregroundColor(.white)
                    } else {
                        Text("You have successfully \(action) \(input) share of \(ticker)")
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                            .frame(minWidth: 0, maxWidth: 300)
                            .padding()
                            .foregroundColor(.green)
                            .background(.white)
                            .cornerRadius(40)
                    }
                }
            }
        } else {
            VStack{
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .padding()
                    .foregroundColor(.black)
                }
                Text("Trade \(detailVM.description!.name) shares")
                    .fontWeight(.bold)
                
                Spacer()
                HStack{
                    TextField("0", text: $input)
                        .font(.system(size: 85))
                        .keyboardType(.decimalPad)
                        .onChange(of: input) { newInput in
                            let filtered = newInput.filter { "0123456789".contains($0) }
                            if filtered != newInput {
                                self.input = filtered
                            }
                        }
                    Spacer()
                    if input == "" || input == "0" || input == "1" {
                        Text("Share")
                            .font(.largeTitle)
                            .offset(y: 20)
                    } else {
                        Text("Shares")
                            .font(.largeTitle)
                            .offset(y: 20)
                    }
                }
                HStack{
                    Spacer()
                    if input == "" || input == "0" {
                        Text("x $\(detailVM.price!.c, specifier: "%.2f")/share = $0.00")
                            .font(.title3)
                    } else {
                        Text("x $\(detailVM.price!.c, specifier: "%.2f")/share = $\(detailVM.price!.c * Double(input)!, specifier: "%.2f")")
                            .font(.title3)
                    }
                }
                Spacer()
                Text("$\(balance, specifier: "%.2f") available to buy \(detailVM.description!.ticker)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding()
                HStack{
                    Button {
//                        print("Click Buy")
                        self.ticker = detailVM.description!.ticker
                        self.action = "bought"
                        self.theInput = input
                        
                        if input == "" {
                            self.toastText = "Please enter a valid amount"
                            withAnimation {
                                self.showToast.toggle()
                            }
                        }else if Int(input)! < 1 {
                            self.toastText = "Cannot buy non-positive shares"
                            withAnimation {
                                self.showToast.toggle()
                            }
                        }else if detailVM.price!.c * Double(input)! > balance {
                            self.toastText = "Not enough money to buy"
                            withAnimation {
                                self.showToast.toggle()
                            }
                        }else{
                            if portfolio.contains(where: {$0.ticker == ticker}){
                                let item = portfolio.filter({$0.ticker == ticker}).first
                                let prevTotal = item!.totalPrice
                                let prevShare = item!.share

                                portfolio.removeAll(where: {$0.ticker == ticker})
                                portfolio.append(StoredType(ticker: ticker, name: detailVM.description!.name, totalPrice: prevTotal! + Double(input)! * detailVM.price!.c, share: prevShare! + Int(input)!, change: 0, changePercentage: 0))
                                
                            }else{
                                portfolio.append(StoredType(ticker: ticker, name: detailVM.description!.name, totalPrice: detailVM.price!.c * Double(input)!, share: Int(input)!, change: 0, changePercentage: 0))
                            }
                            balance = balance - detailVM.price!.c * Double(input)!
                            showingSheet.toggle()
                        }
                    } label: {
                        Text("Buy")
                            .frame(minWidth: 0, maxWidth: 130)
                            .padding()
                            .foregroundColor(.white)
                            .background(.green)
                            .cornerRadius(40)
                    }
                    Spacer()
                    Button {
//                        print("Click Sell")
                        self.ticker = detailVM.description!.ticker
                        self.action = "sold"
                        self.theInput = input
                        
                        if input == "" {
                            self.toastText = "Please enter a valid amount"
                            withAnimation {
                                self.showToast.toggle()
                            }
                        }else if Int(input)! < 1 {
                            self.toastText = "Cannot sell non-positive shares"
                            withAnimation {
                                self.showToast.toggle()
                            }
                        }else if !portfolio.contains(where: {$0.ticker == ticker}) || portfolio.filter({$0.ticker == ticker}).first!.share < Int(input)! {
                            self.toastText = "Not enough shares to sell"
//                            print("Not enough shares to sell")
                            withAnimation {
                                self.showToast.toggle()
                            }
                        }else{
                            let item = portfolio.filter({$0.ticker == ticker}).first
                            if item!.share == Int(input)!{
                                portfolio.removeAll(where: {$0.ticker == ticker})
                            }else{
                                portfolio.removeAll(where: {$0.ticker == ticker})
                                portfolio.append(StoredType(ticker: ticker, name: detailVM.description!.name, totalPrice: item!.totalPrice - Double(input)! * detailVM.price!.c, share: item!.share - Int(input)!, change: 0, changePercentage: 0))
                            }
                            balance = balance + detailVM.price!.c * Double(input)!
                            showingSheet.toggle()
                        }
                    } label: {
                        Text("Sell")
                            .frame(minWidth: 0, maxWidth: 130)
                            .padding()
                            .foregroundColor(.white)
                            .background(.green)
                            .cornerRadius(40)
                    }
                }
            }
            .toast(isShowing: $showToast, text: Text("\(toastText)"))
            .padding()
        }
    }
}

struct TradeSheet_Previews: PreviewProvider {
    static var previews: some View {
        TradeSheet()
            .environmentObject(DetailVM())
    }
}

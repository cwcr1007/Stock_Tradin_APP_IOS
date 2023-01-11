//
//  StatsAboutSection.swift
//  stockTrading
//
//  Created by Bob Dai on 4/19/22.
//

import SwiftUI

struct StatsAboutSection: View {
    var ticker: String!
    @EnvironmentObject var detailVM: DetailVM
    
    
    var body: some View {
        VStack{
            HStack {
                Text("Stats")
                    .font(.title2)
                Spacer()
            }
            .padding(.bottom)
            
            HStack{
                VStack{
                    HStack {
                        Text("High Price")
                            .fontWeight(.bold)
                        if let h = detailVM.price?.h {
                            Text("\(h, specifier: "%.2f")")
                        }
                    }
                    .padding(.bottom, 1)
                    HStack {
                        Text("Low Price")
                            .fontWeight(.bold)
                        if let l = detailVM.price?.l {
                            Text("\(l, specifier: "%.2f")")
                        }
                    }
                    .padding(.bottom)
                }
                .padding(.trailing)
                                
                VStack{
                    HStack {
                        Text("Open Price")
                            .fontWeight(.bold)
                        if let o = detailVM.price?.o {
                            Text("\(o, specifier: "%.2f")")
                        }
                    }
                    .padding(.bottom, 1)
                    HStack {
                        Text("Prev. Close")
                            .fontWeight(.bold)
                        if let pc = detailVM.price?.pc {
                            Text("\(pc, specifier: "%.2f")")
                        }
                    }
                    .padding(.bottom)
                }
                Spacer()
                
            }
            .font(.footnote)
            
            
            
            HStack {
                Text("About")
                    .font(.title2)
                Spacer()
            }
            .padding(.bottom)
            
            HStack{
                VStack(alignment: .leading){
                    Text("IPO Start Date:")
                        .fontWeight(.bold)
                        .padding(.bottom, 1)
                    Text("Industry:")
                        .fontWeight(.bold)
                        .padding(.bottom, 1)
                    Text("Webpage:")
                        .fontWeight(.bold)
                        .padding(.bottom, 1)
                    Text("Company peers:")
                        .fontWeight(.bold)
                        .padding(.bottom)
                }
                .padding(.trailing)
                
                VStack(alignment: .leading){
                    if let ipo = detailVM.description?.ipo {
                        Text("\(ipo)")
                            .padding(.bottom, 1)
                    }
                    if let finn = detailVM.description?.finnhubIndustry {
                        Text("\(finn)")
                            .padding(.bottom, 1)
                    }
                    if let url = detailVM.description?.weburl {
                        Link(url, destination: URL(string: url)!)
                            .padding(.bottom, 1)
                    }
                    
                    if let peer = detailVM.peer {
                        ScrollView (.horizontal, showsIndicators: false) {
                             HStack {
                                 ForEach(peer, id:\.self) { string in
                                     NavigationLink {
                                         StockDetail(ticker: string)
                                             .environmentObject(DetailVM())
                                     } label: {
                                         Text("\(string),")
                                     }
                                 }
                             }
                        }
                        .frame(height: 30)
                        .offset(y: -10)
                    }
                }
                Spacer()
            }
            .font(.footnote)
            
        }
        .padding([.leading, .trailing])
    }
}

struct StatsAboutSection_Previews: PreviewProvider {
    static var previews: some View {
        StatsAboutSection()
            .environmentObject(DetailVM())
    }
}

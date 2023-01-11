//
//  StockDetail.swift
//  stockTrading (iOS)
//
//  Created by Bob Dai on 4/14/22.
//

import SwiftUI
import Kingfisher

struct StockDetail: View {
    var ticker: String!
    @State var showToast: Bool = false
    @State var toastText: String = ""
    @AppStorage("favorite") var favorite: [StoredType] = []
    @EnvironmentObject var detailVM: DetailVM
    
    var body: some View {
        if detailVM.price == nil || detailVM.description == nil || detailVM.peer == nil || detailVM.social == nil || detailVM.news == nil || detailVM.description!.ticker != ticker{
            ProgressView {
                Text("Fetching Data...")
            }
            .onAppear {
                detailVM.fetchData(ticker)
            }
        } else {
            ScrollView(.vertical){
                DetailHeader()
                    .navigationTitle(ticker)
                TabView{
                    HourlyView(ticker: detailVM.description!.ticker, priceChange: detailVM.price!.d, endTime: detailVM.price!.t)
                        .tabItem {
                            Label("Hourly", systemImage: "chart.xyaxis.line")
                        }
                        .aspectRatio(contentMode: .fill)
                    HistoricalView(ticker: detailVM.description!.ticker, priceChange: detailVM.price!.d, endTime: detailVM.price!.t)
                        .tabItem {
                            Label("Historical", systemImage: "clock.fill")
                        }
                }
                .frame(height: 450)
                
                
                PortfolioSection(ticker: ticker)
                StatsAboutSection()
                SocialTable()
                TrendView(ticker: ticker)
                    .frame(height: 400)
                    .padding()
                HistoricalEPSView(ticker: ticker)
                    .frame(height: 400)
                    .padding()
                
                NewsView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if favorite.contains(where: {$0.ticker == ticker}) {
                        Button {
//                            print("press removing")
                            favorite.removeAll(where: {$0.ticker == ticker})
                            self.toastText = "Removing \(ticker!) to Favorites"
                            withAnimation {
                                self.showToast.toggle()
                            }
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }
                    } else {
                        Button {
//                            print("press adding")
                            favorite.append(StoredType(ticker: ticker, name: detailVM.description!.name, totalPrice: detailVM.price!.c, share: 0, change: detailVM.price!.d, changePercentage: detailVM.price!.dp))
                            self.toastText = "Adding \(ticker!) to Favorites"
                            withAnimation {
                                self.showToast.toggle()
                            }
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
            }
            .toast(isShowing: $showToast, text: Text("\(toastText)"))
        }
    }
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}


struct StockDetail_Previews: PreviewProvider {
    static var previews: some View {
        StockDetail(ticker: "AAPL")
            .environmentObject(DetailVM())
    }
}

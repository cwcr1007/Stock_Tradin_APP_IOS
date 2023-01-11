//
//  HomeView.swift
//  stockTrading (iOS)
//
//  Created by Bob Dai on 4/10/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var autoVM = AutoViewModel()
    @ObservedObject var searchBar: SearchBar = SearchBar()
    @ObservedObject var detailVM = DetailVM()
    var priceVM = PriceVM()
    
    var body: some View {
        NavigationView{
            VStack{
                if !searchBar.text.isEmpty {
                    List{
                        ForEach(autoVM.autoArr, id: \.symbol) { auto in
                            NavigationLink {
                                StockDetail(ticker: auto.symbol)
                                    .environmentObject(DetailVM())
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(auto.symbol)
                                        .fontWeight(.bold)
                                    Text(auto.description)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                } else {
                    List{
                        Section() {
                            Text(Date.now, format: .dateTime.day().month().year())
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.gray)
                        }
                        Section(header: Text("PORTFOLIO").font(.footnote).foregroundColor(.gray)) {
                            Portfolio(priceVM: priceVM)
                                .environmentObject(DetailVM())
                        }
                        Section(header: Text("FAVORITE").font(.footnote).foregroundColor(.gray)) {
                            Favorites()
                                .environmentObject(DetailVM())
                        }
                        Section() {
                            Footer()
                        }
                    }
                    .listStyle(.insetGrouped)
                    .navigationTitle("Stocks")
                    .toolbar {
                        EditButton()
                    }
                }
//                
//                Button {
//                    if let bundleID = Bundle.main.bundleIdentifier {
//                        UserDefaults.standard.removePersistentDomain(forName: bundleID)
//                    }
//                } label: {
//                    Text("reset")
//                }

            }
            .add(self.searchBar)
            .onChange(of: searchBar.text) { ticker in
                autoVM.debouncer.run {
                    autoVM.fetchAuto(ticker)
                }
            }
            
        }
    }
}
            
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


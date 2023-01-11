//
//  NewsView.swift
//  stockTrading
//
//  Created by Bob Dai on 4/21/22.
//

import SwiftUI
import Kingfisher


extension TimeInterval {
    func format() -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .short
        formatter.zeroFormattingBehavior = .dropAll
        return formatter.string(from: self)
    }
}

struct NewsView: View {
    @EnvironmentObject var detailVM: DetailVM
    @State private var showingSheet = false
    @State var selectedItem: NewsType?
    
    var body: some View {
        VStack {
            HStack{
                Text("News")
                    .font(.title2)
                Spacer()
            }
            .padding([.leading, .trailing])
            
            if var newsArr = detailVM.news {
                let firstNews = newsArr.removeFirst()
                
                VStack{
                    KFImage(URL(string: firstNews.image))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 350, height: 250, alignment: .center)
                        .cornerRadius(10)
                    
                    HStack{
                        Text(firstNews.source)
                        Text("\(Date.now.timeIntervalSince(Date(timeIntervalSince1970: Double(firstNews.datetime))).format()!)")
                        Spacer()
                    }
                    .foregroundColor(.gray)
                    .font(.caption)
                    .padding([.top, .bottom], 2)
                    
                    HStack{
                        Text(firstNews.headline)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
                .padding([.leading, .trailing])
                .onTapGesture {
                    showingSheet.toggle()
                    self.selectedItem = firstNews
                }
                .sheet(isPresented: $showingSheet) {
                    SheetView(newsItem: $selectedItem)
                }
                
                Divider()
                
                ForEach(newsArr, id: \.id) { item in
                    HStack{
                        VStack{
                            HStack{
                                Text(item.source)
                                    .fontWeight(.bold)
                                Text("\(Date.now.timeIntervalSince(Date(timeIntervalSince1970: Double(item.datetime))).format()!)")
                                Spacer()
                            }
                            .foregroundColor(.gray)
                            .font(.caption)
                            .padding(.bottom, 2)
                            
                            HStack{
                                Text(item.headline)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            Spacer()
                        }
                        
                        KFImage(URL(string: item.image))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 90, alignment: .center)
                            .cornerRadius(10)
                    }
                    .padding([.top, .bottom], 5)
                    .onTapGesture {
                        showingSheet.toggle()
                        self.selectedItem = item
                    }
                    .sheet(isPresented: $showingSheet) {
                        SheetView(newsItem: $selectedItem)
                    }
                }
                .padding([.leading, .trailing])
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
            .environmentObject(DetailVM())
    }
}

//
//  SheetView.swift
//  stockTrading
//
//  Created by Bob Dai on 4/22/22.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var newsItem: NewsType!;
        
    var body: some View {
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
            HStack{
                Text(newsItem.source)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            HStack{
                Text("\(newsItem.datetime)")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            
            Divider()
            
            HStack{
                Text(newsItem.headline)
                    .fontWeight(.bold)
                    .font(.headline)
                Spacer()
            }
            HStack{
                Text(newsItem.summary)
                    .font(.callout)
                Spacer()
            }
            HStack{
                Text("For more details click ")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Link("here", destination: URL(string: newsItem.url)!)
                    .font(.footnote)
                Spacer()
            }
            HStack{
                if let url = ("https://twitter.com/intent/tweet?text=" + newsItem.headline + "&url=" + newsItem.url).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                    Link(destination: URL(string: url)!) {
                        Image("twitterIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50, alignment: .center)
                    }
                }

                
                Link(destination: URL(string: "https://www.facebook.com/sharer/sharer.php?u=" + newsItem.url + "&amp;src=sdkpreparse")!) {
                    Image("metaIcon")
                         .resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(width: 50, height: 50, alignment: .center)
                }
                Spacer()
            }
            .padding(.top)
            Spacer()
        }
        .padding()
        
    }
}

//struct SheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        SheetView()
//    }
//}

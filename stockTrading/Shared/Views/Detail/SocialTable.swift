//
//  SocialTable.swift
//  stockTrading
//
//  Created by Bob Dai on 4/20/22.
//

import SwiftUI

struct SocialTable: View {
    @EnvironmentObject var detailVM: DetailVM
    
    var body: some View {
        VStack{
            HStack {
                Text("Insights")
                    .font(.title2)
                Spacer()
            }
            
            HStack{
                Spacer()
                Text("Social Sentiments")
                    .font(.title2)
                    .padding()
                Spacer()
            }
            
            HStack{
                VStack(alignment: .leading){
                    Divider()
                    Text(detailVM.description!.name)
                        .fontWeight(.bold)
                    Divider()
                    Text("Total\nMentions")
                        .fontWeight(.bold)
                    Divider()
                    Text("Positive\nMentions")
                        .fontWeight(.bold)
                    Divider()
                    Text("Negative\nMentions")
                        .fontWeight(.bold)
                    Divider()
                }
                
                VStack(alignment: .leading){
                    Divider()
                    Text("Reddit")
                        .fontWeight(.bold)
                    Divider()
                    Text("\(detailVM.social!.reddit)")
                        .padding(8)
                    Divider()
                    Text("\(detailVM.social!.Rpositive)")
                        .padding(8)
                    Divider()
                    Text("\(detailVM.social!.Rnegative)")
                        .padding(8)
                    Divider()
                }
                
                VStack(alignment: .leading){
                    Divider()
                    Text("Twitter")
                        .fontWeight(.bold)
                    Divider()
                    Text("\(detailVM.social!.twitter)")
                        .padding(8)
                    Divider()
                    Text("\(detailVM.social!.Tpositive)")
                        .padding(8)
                    Divider()
                    Text("\(detailVM.social!.Tnegative)")
                        .padding(8)
                    Divider()
                }
            }
            .font(.caption)
        }
        .padding([.leading, .trailing])
    }
}

struct SocialTable_Previews: PreviewProvider {
    static var previews: some View {
        SocialTable()
            .environmentObject(DetailVM())
    }
}

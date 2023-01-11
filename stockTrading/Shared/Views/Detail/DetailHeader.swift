//
//  DetailHeader.swift
//  stockTrading
//
//  Created by Bob Dai on 4/21/22.
//

import SwiftUI
import Kingfisher


struct DetailHeader: View {
    @EnvironmentObject var detailVM: DetailVM
    
    
    var body: some View {
        HStack{
            Text(detailVM.description!.name)
                .foregroundColor(.gray)
                .fontWeight(.bold)
            Spacer()
            KFImage(URL(string: detailVM.description!.logo)!)
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
        }
        .padding([.leading, .trailing], 15)
        
        HStack{
            Text("$\(detailVM.price!.c, specifier: "%.2f")")
                .font(.title)
                .fontWeight(.bold)
                
            if detailVM.price!.d > 0 {
                Image(systemName: "arrow.up.right")
                    .foregroundColor(.green)
                Text("\(detailVM.price!.d, specifier: "%.2f") (\(detailVM.price!.dp, specifier: "%.2f")%)")
                    .foregroundColor(.green)
                    .font(.title3)
            }else if detailVM.price!.d < 0 {
                Image(systemName: "arrow.down.forward")
                    .foregroundColor(.red)
                Text("\(detailVM.price!.d, specifier: "%.2f") (\(detailVM.price!.dp, specifier: "%.2f")%)")
                    .foregroundColor(.red)
                    .font(.title3)
            }else{
                Image(systemName: "minus")
                    .foregroundColor(.gray)
                Text("\(detailVM.price!.d, specifier: "%.2f") (\(detailVM.price!.dp, specifier: "%.2f")%)")
                    .foregroundColor(.gray)
                    .font(.title3)
            }
            Spacer()
        }
        .padding([.leading, .trailing], 15)
    }
}

struct DetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        DetailHeader()
            .environmentObject(DetailVM())
    }
}

//
//  Favorites.swift
//  stockTrading (iOS)
//
//  Created by Bob Dai on 4/10/22.
//

import SwiftUI

struct Favorites: View {
//    @ObservedObject var priceVM = PriceVM()
    @EnvironmentObject var detailVM: DetailVM
    @AppStorage("favorite") var favorite: [StoredType] = []
    
    func delete(at offsets: IndexSet) {
        favorite.remove(atOffsets: offsets)
    }
    func move(from source: IndexSet, to destination: Int) {
        favorite.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
        ForEach(favorite, id: \.ticker) { item in
            FavoriteRow(item: item)
        }
        .onDelete(perform: delete)
        .onMove(perform: move)
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
    }
}


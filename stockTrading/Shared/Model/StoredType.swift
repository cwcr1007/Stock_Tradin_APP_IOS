//
//  StoredType.swift
//  stockTrading (iOS)
//
//  Created by Bob Dai on 5/1/22.
//

import Foundation

struct StoredType: Codable{
    var ticker: String!
    var name: String!
    var totalPrice: Double!
    var share: Int!
    var change: Double!
    var changePercentage: Double!
//    var lastestPrice: Double!
}

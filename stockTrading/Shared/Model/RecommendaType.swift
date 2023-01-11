//
//  RecommendaType.swift
//  stockTrading (iOS)
//
//  Created by Bob Dai on 4/14/22.
//

import Foundation


struct RecommendaType: Decodable{
    
    var buy: Int!
    var hold: Int!
    var period: String!
    var sell: Int!
    var strongBuy: Int!
    var strongSell: Int!
    var symbol: String!
}

//
//  EarningType.swift
//  stockTrading (iOS)
//
//  Created by Bob Dai on 4/14/22.
//

import Foundation

struct EarningType: Decodable{
    var actual: Double!
    var estimate: Double!
    var period: String!
    var surprise: Double!
    var surprisePercent: Double!
    var symbol: String!
}

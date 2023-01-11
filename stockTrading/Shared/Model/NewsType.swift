//
//  NewsType.swift
//  stockTrading
//
//  Created by Bob Dai on 4/21/22.
//

import Foundation

struct NewsType: Decodable{
    var category: String!;
    var datetime: Int!;
    var headline: String!;
    var id: Int!;
    var image: String!;
    var related: String!;
    var source: String!;
    var summary: String!;
    var url: String!;

}

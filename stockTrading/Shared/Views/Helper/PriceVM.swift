//
//  PriceVM.swift
//  stockTrading (iOS)
//
//  Created by Bob Dai on 5/1/22.
//

import Foundation
import Alamofire
import SwiftUI

class PriceVM: ObservableObject {
    @Published var price: PriceType?
    @Published var value: Double = 0
    @Published var allPrice: [String: PriceType] = [:]
    @AppStorage("stockValue") var stockValue: Double = 0
    @AppStorage("portfolio") var portfolio: [StoredType] = []
    
    @AppStorage("aapl") var aapl: Double = 0
    
    var baseUrl = "https://mynewonework.wl.r.appspot.com/api/"
    
    func fetchAll(_ portfolio: [StoredType]){
        for item in portfolio {
            fetchItem(item.ticker, item.share, item.totalPrice)
        }
//        print(self.value)
    }
    
    func fetchItem(_ ticker: String, _ share: Int, _ totalPrice: Double){
        AF.request(baseUrl + "price/\(ticker)").validate().responseDecodable(of: PriceType.self){(response) in
            switch response.result {
            case let .success(res):
                var oldValue: Double = totalPrice / Double(share)
                if self.allPrice[ticker] != nil{
                    oldValue = self.allPrice[ticker]!.c
                }
                
                else if ticker == "AAPL"{
                    oldValue = self.aapl
                }
                
                let newValue = res.c
                self.aapl = newValue!
                
                self.value += (newValue! - oldValue) * Double(share)
                self.stockValue += (newValue! - oldValue) * Double(share)
                self.allPrice[ticker] = res
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func fetchPrice(_ ticker: String){
        AF.request(baseUrl + "price/\(ticker)").validate().responseDecodable(of: PriceType.self){(response) in
            switch response.result {
            case let .success(res):
                self.price = res
            case let .failure(error):
                print(error)
            }
        }
    }
}

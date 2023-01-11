//
//  FetchData.swift
//  stockTrading (iOS)
//
//  Created by Bob Dai on 4/10/22.
//

import Foundation
import Alamofire

extension Date {
    func get(_ type: Calendar.Component)-> String {
        let calendar = Calendar.current
        let t = calendar.component(type, from: self)
        return (t < 10 ? "0\(t)" : t.description)
    }
}

class DetailVM: ObservableObject {
    @Published var description: DescripType?
    @Published var price: PriceType?
    @Published var social: SocialType?
    @Published var peer: [String]?
    @Published var news: [NewsType]?
    
    var baseUrl = "https://mynewonework.wl.r.appspot.com/api/"
    
    func fetchData(_ ticker: String){
        self.fetchDescription(ticker)
        self.fetchPrice(ticker)
        self.fetchPeer(ticker)
        self.fetchSocial(ticker)
        self.fetchNews(ticker)
    }
    
    func fetchDescription(_ ticker: String){
        AF.request(baseUrl + "description/\(ticker)").validate().responseDecodable(of: DescripType.self){(response) in
            switch response.result {
                case let .success(res):
                    //print("Response: \(res)")
                    self.description = res
                case let .failure(error):
                    print(error)
            }
        }
    }
    
    func fetchPrice(_ ticker: String){
        AF.request(baseUrl + "price/\(ticker)").validate().responseDecodable(of: PriceType.self){(response) in
            switch response.result {
                case let .success(res):
                    //print("Response: \(res)")
                    self.price = res
                case let .failure(error):
                    print(error)
            }
        }
    }
    
    func fetchSocial(_ ticker: String){
        AF.request(baseUrl + "social/\(ticker)/2022-01-01").validate().responseDecodable(of: SocialType.self){(response) in
            switch response.result {
                case let .success(res):
                    //print("Response: \(res)")
                    self.social = res
                case let .failure(error):
                    print(error)
            }
        }
    }
    
    func fetchPeer(_ ticker: String){
        AF.request(baseUrl + "peer/\(ticker)").validate().responseDecodable(of: [String].self){(response) in
            switch response.result {
                case let .success(res):
                    //print("Response: \(res)")
                    self.peer = res
                case let .failure(error):
                    print(error)
            }
        }
    }
    
    func fetchNews(_ ticker: String){

        let toDate = Date()
        let fromDate = Date.now - 86400 * 6
        let from = "\(fromDate.get(.year))-\(fromDate.get(.month))-\(fromDate.get(.day))"
        let to = "\(toDate.get(.year))-\(toDate.get(.month))-\(toDate.get(.day))"
        
        AF.request(baseUrl + "news/\(ticker)/\(from)&\(to)").validate().responseDecodable(of: [NewsType].self){(response) in
            switch response.result {
                case let .success(res):
//                    print("Response: \(res)")
                    self.news = res
                case let .failure(error):
                    print(error)
            }
        }
    }
}

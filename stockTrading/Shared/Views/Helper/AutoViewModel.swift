//
//  AutoViewModel.swift
//  stockTrading (iOS)
//
//  Created by Bob Dai on 4/30/22.
//

import Foundation
import SwiftUI
import Alamofire


class AutoViewModel: ObservableObject {
    @Published var autoArr: [AutoType] = []
    @Published var debouncer = Debouncer(delay: 0.5)
    var baseUrl = "https://mynewonework.wl.r.appspot.com/api/auto/"
    
    func fetchAuto(_ ticker: String){
        if ticker == ""{
            autoArr = []
            return
        }
        AF.request(baseUrl + ticker).validate().responseDecodable(of: [AutoType].self){(response) in
            switch response.result {
                case let .success(res):
                    //print("Response: \(res)")
                    self.autoArr = res
                case let .failure(error):
                    print(error)
            }
        }
    }
}

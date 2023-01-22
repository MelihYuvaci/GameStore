//
//  HomeModel.swift
//  GameStore
//
//  Created by Melih Yuvacı on 16.01.2023.
//

import Foundation
import Alamofire

protocol HomeModelDelegate : AnyObject{
    func didDataFetch()
    func didFailWithError(error: Error)
}

class HomeModel {
    
    private(set) var data: [GameData] = []
    
    weak var delegate: HomeModelDelegate?
    
    func fetchData(filter: String){
        AF.request("https://api.rawg.io/api/games?key=8a73fc08dbb0431b96e9cb965775dc0b\(filter)").responseDecodable(of:ApiData.self) { res in
            guard let response = res.value else {
                self.delegate?.didFailWithError(error: res.error!)
                return
            }
            self.data = response.results ?? []
            self.delegate?.didDataFetch()
        }
    }
}

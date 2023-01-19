//
//  SearchModel.swift
//  GameStore
//
//  Created by Melih Yuvacı on 19.01.2023.
//

import Foundation
import Alamofire

protocol SearchModelDelegate: AnyObject {
    func didDataFetch()
    func didFailWithError(error: Error)
}

class SearchModel{
    
    private(set) var data : [SearchData] = []
    
    weak var delegate : SearchModelDelegate?
    
    func fetchData(search: String){
        AF.request("https://api.rawg.io/api/games?key=8a73fc08dbb0431b96e9cb965775dc0b&search=\(search)").responseDecodable(of:SearchApi.self) { res in
            guard let response = res.value else {
                self.delegate?.didFailWithError(error: res.error!)
                return
            }
            self.data = response.results ?? []
            self.delegate?.didDataFetch()
        }
    }
}

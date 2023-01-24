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
        AF.request("\(Constants.Home.Model.modelApi)\(filter)").responseDecodable(of:ApiData.self) { res in
            guard let response = res.value else {
                self.delegate?.didFailWithError(error: res.error!)
                return
            }
            self.data = response.results ?? []
            self.delegate?.didDataFetch()
        }
    }
}

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
//MARK: - Business Logic

class SearchModel{
    
    private(set) var data : [SearchData] = []
    
    weak var delegate : SearchModelDelegate?
    
    func fetchData(search: String){
        AF.request("\(Constants.Search.Model.modelApi)\(search)").responseDecodable(of:SearchApi.self) { res in
            guard let response = res.value else {
                self.delegate?.didFailWithError(error: res.error!)
                return
            }
            self.data = response.results ?? []
            self.delegate?.didDataFetch()
        }
    }
}

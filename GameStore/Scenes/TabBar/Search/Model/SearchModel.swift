//
//  SearchModel.swift
//  GameStore
//
//  Created by Melih Yuvacı on 19.01.2023.
//

import Foundation

protocol SearchModelDelegate: AnyObject {
    func didDataFetch()
    func didFailWithError(error: Error)
}

class SearchModel{
    
    weak var delegate : SearchModelDelegate?
    
    func fetchData(search: String){
        
    }
    
}

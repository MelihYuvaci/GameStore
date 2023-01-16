//
//  HomeModel.swift
//  GameStore
//
//  Created by Melih Yuvacı on 16.01.2023.
//

import Foundation

protocol HomeModelDelegate : AnyObject{
    func didDataFetch()
    func didDataCouldntFetch()
}

class HomeModel {
    
    private(set) var data: [Any] = []
    
    weak var delegate: HomeModelDelegate?
    
    func fetchData(){
        
    }
    
}

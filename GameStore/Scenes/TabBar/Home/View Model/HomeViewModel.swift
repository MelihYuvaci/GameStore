//
//  HomeViewModel.swift
//  GameStore
//
//  Created by Melih Yuvacı on 16.01.2023.
//

import Foundation

class HomeViewModel{
    
    private var model = HomeModel()
    
    init() {
        model.delegate = self
    }
    
    func viewDidLoad(){
        model.fetchData()
    }
    
}

extension HomeViewModel: HomeModelDelegate{
    
    func didDataFetch() {
        
    }
    
    func didDataCouldntFetch() {
        
    }
    
}

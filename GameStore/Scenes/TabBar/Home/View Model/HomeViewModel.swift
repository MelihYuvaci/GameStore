//
//  HomeViewModel.swift
//  GameStore
//
//  Created by Melih Yuvacı on 16.01.2023.
//

import Foundation

class HomeViewModel{
    
    private var model = HomeModel()
    
    var onErrorDetected : ((String)-> ())?
    var refreshItems:(([HomeCellModel])-> ())?
    
    init() {
        model.delegate = self
    }
    
    func viewDidLoad(){
        model.fetchData()
    }
    
    func itemPressed(_ index: Int){
        
    }
    
    
    
    
}

extension HomeViewModel: HomeModelDelegate{
    
    func didDataFetch() {
        
    }
    
    func didDataCouldntFetch() {
        
    }
    
}

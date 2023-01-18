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
        let cellModels: [HomeCellModel] = model.data.map{.init(id: $0.id ?? 0, name: $0.name ?? "", imageURL: $0.backgroundImage ?? "")}
        refreshItems?(cellModels)
    }
    
    func didFailWithError(error: Error) {
        print(error)
        onErrorDetected?("Please try again later !")
    }
    
}

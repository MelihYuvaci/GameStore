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
    var isLoadingIndicatorShowing : ((Bool)-> ())?
    
    init() {
        model.delegate = self
    }
    
    func viewDidLoad(filterText: String){
        isLoadingIndicatorShowing?(true)
        model.fetchData(filter: filterText)
    }
    
}

//MARK: - Data Binding

extension HomeViewModel: HomeModelDelegate{
    
    func didDataFetch() {
        isLoadingIndicatorShowing?(false)
        let cellModels: [HomeCellModel] = model.data.map{.init(id: $0.id ?? 0, name: $0.name ?? "", imageURL: $0.backgroundImage ?? "")}
        refreshItems?(cellModels)
    }
    
    func didFailWithError(error: Error) {
        isLoadingIndicatorShowing?(false)
        print(error)
        onErrorDetected?("Please try again later !")
    }
    
}

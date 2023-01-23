//
//  SearchViewModel.swift
//  GameStore
//
//  Created by Melih Yuvacı on 19.01.2023.
//

import Foundation

class SearchViewModel{
    
    var showData : (([SearchCellModel])-> ())?
    var onErrorDetected : ((String)-> ())?
    var isLoadingIndicatorShowing : ((Bool)-> ())?
    
    private let model = SearchModel()
    
    init() {
        model.delegate = self
    }
    
    func viewDidLoad(searchText: String){
        isLoadingIndicatorShowing?(true)
        model.fetchData(search: searchText)
    }
    
}

extension SearchViewModel: SearchModelDelegate{
    
    func didDataFetch() {
        isLoadingIndicatorShowing?(false)
        let cellModels: [SearchCellModel] = model.data.map{.init(id: $0.id ?? 0, name: $0.name ?? "", imageURL: $0.backgroundImage ?? "")}
        showData?(cellModels)
    }
    
    func didFailWithError(error: Error) {
        isLoadingIndicatorShowing?(false)
        print(error)
        onErrorDetected?("Please Try Again Later!")
    }
    
}

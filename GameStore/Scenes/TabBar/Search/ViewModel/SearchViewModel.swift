//
//  SearchViewModel.swift
//  GameStore
//
//  Created by Melih Yuvacı on 19.01.2023.
//

import Foundation

class SearchViewModel{
    
    var showData : ((String)-> ())?
    var onErrorDetected : ((String)-> ())?
    
    private let model = SearchModel()
    
    init() {
        model.delegate = self
    }
    
    func viewDidLoad(searchText: String){
        model.fetchData(search: searchText)
    }
    
}

extension SearchViewModel: SearchModelDelegate{
    
    func didDataFetch() {
        showData?("Data")
    }
    
    func didFailWithError(error: Error) {
        print(error)
        onErrorDetected?("Please Try Again Later!")
    }
    
}

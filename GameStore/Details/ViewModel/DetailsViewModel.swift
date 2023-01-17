//
//  DetailsViewModel.swift
//  GameStore
//
//  Created by Melih Yuvacı on 17.01.2023.
//

import Foundation

class DetailsViewModel{
    
    var onErrorDetected : ((String)-> ())?
    var refreshItems : ((String)-> ())?
    
    private let model = DetailsModel()
    
    init() {
        model.delegate = self
    }
    
    func viewDidLoad(){
        model.fetchData()
    }
    
}

extension DetailsViewModel: DetailsModelDelegate{
  
    func didDataFetch() {
        <#code#>
    }
    
    func didFailWithError(error: Error) {
        print(error)
        onErrorDetected?("Please try again later !")
    }
    
    
}

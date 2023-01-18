//
//  DetailsViewModel.swift
//  GameStore
//
//  Created by Melih Yuvacı on 17.01.2023.
//

import Foundation

class DetailsViewModel{
    
    var onErrorDetected : ((String)-> ())?
    var showData : ((Details)-> ())?
    
    private let model = DetailsModel()
    
    init() {
        model.delegate = self
    }
    
    func viewDidLoad(id: Int){
        model.fetchData(id: id)
    }
    
}

extension DetailsViewModel: DetailsModelDelegate{
    func didDataFetch(data: Details) {
        showData?(data)
    }
    
    func didFailWithError(error: Error) {
        print(error)
        onErrorDetected?("Please try again later !")
    }
    
    
}

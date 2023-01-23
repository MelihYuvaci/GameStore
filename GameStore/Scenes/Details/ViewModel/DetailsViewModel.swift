//
//  DetailsViewModel.swift
//  GameStore
//
//  Created by Melih Yuvacı on 17.01.2023.
//

import Foundation

class DetailsViewModel{
    
    let favorite : Bool?
    let name : String?
    var isLoadingIndicatorShowing : ((Bool)-> ())?
   
    init(favorite: Bool?, name: String?) {
        self.favorite = favorite
        self.name = name
        
        model.delegate = self
    }
    
    var onErrorDetected : ((String)-> ())?
    var showData : ((Details)-> ())?
    
    private let model = DetailsModel()
    
    func viewDidLoad(id: Int){
        isLoadingIndicatorShowing?(true)
        model.fetchData(id: id)
    }
    
    func saveFavorites(completion: @escaping (Bool)-> Void){
        FavoriteCoreDataManager.shared.saveFavorites(name: self.name!, favorite: self.favorite!, completion: completion)
    }
    
}

extension DetailsViewModel: DetailsModelDelegate{
    
    func didDataFetch(data: Details) {
        isLoadingIndicatorShowing?(false)
        showData?(data)
    }
    
    func didFailWithError(error: Error) {
        isLoadingIndicatorShowing?(false)
        print(error)
        onErrorDetected?("Please try again later !")
    }
    
}

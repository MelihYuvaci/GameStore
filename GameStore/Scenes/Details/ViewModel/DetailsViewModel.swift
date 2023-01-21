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
   
    init(favorite: Bool?, name: String?) {
        self.favorite = favorite
        self.name = name
        
        model.delegate = self
    }
    
    var onErrorDetected : ((String)-> ())?
    var showData : ((Details)-> ())?
    
    private let model = DetailsModel()
    
    func viewDidLoad(id: Int){
        model.fetchData(id: id)
    }
    
    func saveFavorites(completion: @escaping (Bool)-> Void){
        CoreDataManager.shared.saveFavorites(name: self.name!, favorite: self.favorite!, completion: completion)
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

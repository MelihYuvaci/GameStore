//
//  DetailsModel.swift
//  GameStore
//
//  Created by Melih Yuvacı on 17.01.2023.
//

import Foundation
import Alamofire

protocol DetailsModelDelegate: AnyObject {
    func didDataFetch(data:Details)
    func didFailWithError(error:Error)
}

//MARK: - Business Logic

class DetailsModel {
    
    weak var delegate : DetailsModelDelegate?
    
    func fetchData(id: Int){
        AF.request("\(Constants.Details.Model.modelApi)\(id)\(Constants.Details.Model.apiKey)").responseDecodable(of:DetailsData.self) { res in
            guard let response = res.value else {
                self.delegate?.didFailWithError(error: res.error!)
                return
            }
            let data = Details(imageUrl: response.backgroundImage!, relased: response.released!, title: response.name!, details: response.descriptionRaw!)
            self.delegate?.didDataFetch(data: data)
        }
    }
}

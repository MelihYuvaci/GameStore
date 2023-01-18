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

class DetailsModel {
    
    weak var delegate : DetailsModelDelegate?
    
    func fetchData(id: Int){
        AF.request("https://api.rawg.io/api/games/\(id)?key=8a73fc08dbb0431b96e9cb965775dc0b").responseDecodable(of:DetailsData.self) { res in
            guard let response = res.value else {
                self.delegate?.didFailWithError(error: res.error!)
                return
            }
            let data = Details(imageUrl: response.backgroundImage!, relased: response.released!, title: response.name!, details: response.descriptionRaw!)
            self.delegate?.didDataFetch(data: data)
        }
    }
}

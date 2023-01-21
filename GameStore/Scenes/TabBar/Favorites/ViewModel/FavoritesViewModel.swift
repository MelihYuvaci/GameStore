//
//  FavoritesViewModel.swift
//  GameStore
//
//  Created by Melih Yuvacı on 20.01.2023.
//

import Foundation

class FavoritesViewModel {
    
    var favorites = [Favorites]()
    
    var count : Int {
        return favorites.count
    }
    
    init(){
        self.refreshData()
    }
    
    func favoritesAtIndex(_ index: Int) -> Favorites {
        return favorites[index]
    }
    
    func refreshData(){
        favorites = CoreDataManager.shared.getAllFavorites()
    }
    
    func deleteItem (_ index: Int, completion: @escaping (Bool) -> Void){
        CoreDataManager.shared.deleteFavorites(item: favorites[index], completion: { _ in
            self.refreshData()
            completion(true)
        })
    }
    
    
}

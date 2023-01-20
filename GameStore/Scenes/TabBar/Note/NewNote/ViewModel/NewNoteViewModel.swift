//
//  NewNoteViewModel.swift
//  GameStore
//
//  Created by Melih Yuvacı on 20.01.2023.
//

import Foundation

class NewNoteViewModel{
    
    var name : String
    var comment : String
    
    init(name: String, comment: String) {
        self.name = name
        self.comment = comment
    }
    
    func saveTask(completion: @escaping (Bool)-> Void){
        CoreDataManager.shared.saveNotes(name: self.name, comment: self.comment, completion: completion)
    }
    
}

//
//  NotesViewModel.swift
//  GameStore
//
//  Created by Melih Yuvacı on 20.01.2023.
//

import Foundation

class NotesViewModel {
    
    var notes = [Notes]()
    
    var count : Int {
        return notes.count
    }
    
    init() {
        self.refreshData()
    }
    
    
    func notesAtIndex(_ index: Int) -> Notes {
        return notes[index]
    }
    
    
    func refreshData (){
        notes = NoteCoreDataManager.shared.getAllNotes()
    }
    
    func deleteItem (_ index: Int, completion: @escaping (Bool) -> Void){
        NoteCoreDataManager.shared.deleteNotes(item: notes[index]) { _ in
            self.refreshData()
            completion(true)
        }
    }
    
}


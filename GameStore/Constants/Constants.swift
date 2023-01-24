//
//  Constants.swift
//  GameStore
//
//  Created by Melih Yuvacı on 24.01.2023.
//

import Foundation

struct Constants {
    
    static let baseUrl = "https://api.rawg.io/api/games"
    static let api_Key = "8a73fc08dbb0431b96e9cb965775dc0b"
    static let predicate_Format = "id = %@"
    static let persistant_Container = "DataModel"
    static let storyboard_Name = "Main"
    
    
    
    struct Onboard {
        static let navigationIdentifier = "Tabbar"
    }
    
    struct Home {
        
        struct Model {
            static let modelApi = "\(baseUrl)?key=\(api_Key)"
        }
        
        struct CollectionHelper {
            static let cellIdentifier = "ReusableHomeCell"
            static let nibName = "HomeCell"
            static let storyboardName = storyboard_Name
            static let navigationIdentifier = "DetailsVC"
        }
        
        struct PickerViewHelper{
            static let filterPopularValue = ""
            static let filterOldValue = "&ordering=-created"
            static let filterNewValue = "&ordering=created"
        }
    }
    
    struct Search {
        
        struct Model {
            static let modelApi = "\(baseUrl)?key=\(api_Key)&search="
        }
        
        struct TableViewHelper {
            static let cellIdentifier = "ReusableSearchCell"
            static let nibName = "SearchCell"
            static let storyboardName = storyboard_Name
            static let navigationIdentifier = "DetailsVC"
        }
        
    }
    
    struct Favorites {
        
        struct CoreDataManager {
            static let predicateFormat = predicate_Format
            static let persistantContainerName = persistant_Container
        }
        
        struct View {
            static let nibName = "FavoriteCell"
            static let reusableIdentifier = "ReusableFavoriteCell"
            static let cellIdentifier = "ReusableFavoriteCell"
            static let navigationIdentifier = "AnimationVC"
            static let jsonName = "79053-delete-message"
        }
        
    }
    
    struct Note {
        struct CoreDataManager {
            static let predicateFormat = predicate_Format
            static let persistantContainerName = persistant_Container
        }
        struct View {
            static let navigationIdentifier = "NewNoteVC"
            static let nibName = "NotesCell"
            static let reusableIdentifier = "ReusableNotesCell"
            static let animationNavigationIdentifier = "AnimationVC"
            static let jsonName = "79053-delete-message"
        }
    }
    
    struct NewNote {
        static let navigationIdentifier = "AnimationVC"
        static let jsonName = "1127-success"
        static let notificationSnoozeIdentifier = "Snooze"
        static let notificationDeleteIdentifier = "DeleteAction"
        static let categoryIdentifier = "MyNotificationsCategory"
        static let requestIdentifier = "FirstUserNotification"
    }
    
    struct Details {
        
        struct Model {
            static let modelApi = "\(baseUrl)/"
            static let apiKey = "?key=\(api_Key)"
        }
        
        struct View {
            static let navigationIdentifier = "AnimationVC"
            static let jsonName = "362-like"
        }
        
    }
    
    
}

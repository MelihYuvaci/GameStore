//
//  NewNoteVC.swift
//  GameStore
//
//  Created by Melih Yuvacı on 20.01.2023.
//

import UIKit
import UserNotifications

class NewNoteVC: UIViewController {
    
    @IBOutlet weak var gameName: UITextField!
    @IBOutlet weak var gameComment: UITextField!
    
    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        center.delegate = self
    }
    
    
    @IBAction func saveClicked(_ sender: UIBarButtonItem) {
        
        let viewModel = NewNoteViewModel(name: gameName.text ?? "No text", comment: gameComment.text ?? "No Comment")
        viewModel.saveTask { _ in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
        createNotfications()
        
    }
    
}

extension NewNoteVC {
     func createNotfications() {
        // CONTENT
        let content = UNMutableNotificationContent()
        content.title = "Added"
        content.body = "Girdiğiniz not eklenmiştir"
        content.sound = UNNotificationSound.default
        
        // TRIGGER
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // CUSTOM ACTIONS
        
        // Define Action
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "DeleteAction", title: "Delete", options: [.destructive])
        
        // Create Category
        let category = UNNotificationCategory(identifier: "MyNotificationsCategory", actions: [snoozeAction, deleteAction], intentIdentifiers: [], options: [])
        
        // Register Category
        center.setNotificationCategories([category])
        content.categoryIdentifier = "MyNotificationsCategory"
        
        // REQUEST
        let identifier = "FirstUserNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request) { (error) in
            if error != nil {
                print("Something wrong")
            }
        }
    }
}

extension NewNoteVC : UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}

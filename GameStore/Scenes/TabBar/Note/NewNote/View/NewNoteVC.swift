//
//  NewNoteVC.swift
//  GameStore
//
//  Created by Melih Yuvacı on 20.01.2023.
//

import UIKit

class NewNoteVC: UIViewController {
    
    @IBOutlet weak var gameName: UITextField!
    @IBOutlet weak var gameComment: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveClicked(_ sender: UIBarButtonItem) {
        let viewModel = NewNoteViewModel(name: gameName.text ?? "No text", comment: gameComment.text ?? "No Comment")
        viewModel.saveTask { _ in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

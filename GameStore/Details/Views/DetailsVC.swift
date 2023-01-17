//
//  DetailsVC.swift
//  GameStore
//
//  Created by Melih Yuvacı on 17.01.2023.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var relasedLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    private let viewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBinding()
        viewModel.viewDidLoad()
    }

    @IBAction func favoriteButtonClicked(_ sender: UIBarButtonItem) {
        //ToDo
    }
    
    
}

private extension DetailsVC{
    
    private func setupUI(){
        
    }
    
    func setupBinding(){
        viewModel.refreshItems = {[weak self] items in
            
        }
        
        viewModel.onErrorDetected = {[weak self] message in
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
            
        }
    }

}

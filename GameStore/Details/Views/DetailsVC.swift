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
    
    var detailID : Int?
    
    private let viewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        viewModel.viewDidLoad(id: detailID ?? 0)
        
    }
    
    @IBAction func favoriteButtonClicked(_ sender: UIBarButtonItem) {
        //ToDo
    }
}

private extension DetailsVC{
    
    private func setupBindings(){
        viewModel.showData = {[weak self] items in
            self?.imageView.kf.setImage(with: URL.init(string: items.imageUrl))
            self?.relasedLabel.text = items.relased
            self?.titleLabel.text = items.title
            self?.detailsLabel.text = items.details
        }
        
        viewModel.onErrorDetected = {[weak self] message in
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }
    }
}

struct Details {
    let imageUrl : String
    let relased : String
    let title : String
    let details : String
}



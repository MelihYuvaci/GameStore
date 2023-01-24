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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var detailID : Int?
    var favoriteValue : Bool = false
    private let viewModel = DetailsViewModel(favorite: nil, name: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        viewModel.viewDidLoad(id: detailID ?? 0)
       
    }
    
    @IBAction func favoriteButtonClicked(_ sender: UIBarButtonItem) {
        if titleLabel.text != "" && detailID != nil  {
            
            if favoriteValue == false {
                favoriteValue = true
            }
            
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.Details.View.navigationIdentifier) as? AnimationVC{
                vc.navigationItem.hidesBackButton = true
                vc.jsonName = Constants.Details.View.jsonName
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            let viewModel = DetailsViewModel(favorite: favoriteValue, name: titleLabel.text ?? "No Text")
            if favoriteValue == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                    viewModel.saveFavorites { _ in
                        let alertController = UIAlertController(title: "Information", message: "Favorilere Eklenildi", preferredStyle: .alert)
                        alertController.addAction(.init(title: "Ok", style: .default))
                        self.present(alertController, animated: true)
                    }
                }
            }
        }
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
        viewModel.isLoadingIndicatorShowing = {[weak self] isShowing in
            self?.activityIndicator.isHidden = !isShowing
            isShowing ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }
    }
}

struct Details {
    let imageUrl : String
    let relased : String
    let title : String
    let details : String
}



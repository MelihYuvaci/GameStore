//
//  HomeVC.swift
//  GameStore
//
//  Created by Melih Yuvacı on 16.01.2023.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pickerViewButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel = HomeViewModel()
    private var collectionHelper : HomeVCCollectionHelper!
    private var pickerHelper : HomeVCPickerViewHelper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        viewModel.viewDidLoad(filterText: "")

    }
    
    @IBAction func popUpPicker(_ sender: UIButton){
        
        let alert = pickerHelper.popUpClicked()
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

//MARK: - Presentation Logic

private extension HomeVC{
    
    private func setupUI(){
        collectionHelper = .init(collectionView: collectionView, viewModel: viewModel, navigationController:navigationController!)
        pickerHelper = .init(viewModel: viewModel,pickerViewButton: pickerViewButton)
    }
    
    func setupBindings(){
        
        viewModel.onErrorDetected = {[weak self] message in
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }
        
        viewModel.refreshItems = {[weak self] items in
            self?.collectionHelper.setItems(items)
        }
        
        viewModel.isLoadingIndicatorShowing = {[weak self] isShowing in
            self?.activityIndicator.isHidden = !isShowing
            isShowing ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }
    }
}

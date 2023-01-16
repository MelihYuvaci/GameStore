//
//  HomeVC.swift
//  GameStore
//
//  Created by Melih Yuvacı on 16.01.2023.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = HomeViewModel()
    private var collectionHelper : HomeVCCollectionHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        viewModel.viewDidLoad()
    }
}

private extension HomeVC{
    
    private func setupUI(){
        collectionHelper = .init(collectionView: collectionView, viewModel: viewModel)
    }
    
    func setupBindings(){
        viewModel.onErrorDetected = {[weak self] message in
            
        }
        
        viewModel.refreshItems = {[weak self] items in
            self?.collectionHelper.setItems(items)
        }
    }
    
}

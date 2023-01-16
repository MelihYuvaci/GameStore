//
//  HomeVCCollectionHelper.swift
//  GameStore
//
//  Created by Melih Yuvacı on 16.01.2023.
//

import UIKit

class HomeVCCollectionHelper : NSObject {
    
    typealias RowItem = HomeCellModel
    
    private let cellIdentifier = "ReusableHomeCell"
    
    private var collectionView : UICollectionView?
    private weak var viewModel : HomeViewModel?
    
    private var items: [RowItem] = []
    
    init(collectionView: UICollectionView, viewModel:HomeViewModel) {
        self.collectionView = collectionView
        self.viewModel = viewModel
        super.init()
        
        self.setupCollectionView()
    }
    
    private func setupCollectionView(){
        collectionView?.register(.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    func setItems(_ items: [RowItem]){
        self.items = items
        collectionView?.reloadData()
    }
    
}

extension HomeVCCollectionHelper : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.itemPressed(indexPath.row)
    }
}

extension HomeVCCollectionHelper : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HomeCell
        cell.configure(with: items[indexPath.row])
        return cell
    }
    
}


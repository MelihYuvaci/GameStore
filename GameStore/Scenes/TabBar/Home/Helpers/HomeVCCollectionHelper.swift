//
//  HomeVCCollectionHelper.swift
//  GameStore
//
//  Created by Melih Yuvacı on 16.01.2023.
//

import UIKit

class HomeVCCollectionHelper : NSObject {
    
    typealias RowItem = HomeCellModel
    
    private let cellIdentifier = Constants.Home.CollectionHelper.cellIdentifier
    private var collectionView : UICollectionView?
    private weak var viewModel : HomeViewModel?
    private weak var navigationController: UINavigationController?
    
    private var items: [RowItem?] = []
    
    init(collectionView: UICollectionView, viewModel:HomeViewModel,navigationController:UINavigationController) {
        self.collectionView = collectionView
        self.viewModel = viewModel
        super.init()
        self.setupCollectionView()
        self.navigationController = navigationController
    }
    
}

//MARK: - Setup CollectionView & Items

extension HomeVCCollectionHelper{
    
    private func setupCollectionView(){
        collectionView?.register(.init(nibName: Constants.Home.CollectionHelper.nibName, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
    func setItems(_ items: [RowItem]){
        self.items = items
        collectionView?.reloadData()
    }
    
}

//MARK: - UICollectionViewDelegate

extension HomeVCCollectionHelper : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.Home.CollectionHelper.storyboardName, bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: Constants.Home.CollectionHelper.navigationIdentifier) as? DetailsVC{
            vc.detailID = items[indexPath.row]?.id
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
//MARK: - UICollectionViewDataSource

extension HomeVCCollectionHelper : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HomeCell
        cell.configure(with: items[indexPath.row]!)
        cell.backgroundColor = UIColor(red: 0.97, green: 0.95, blue: 0.95, alpha: 1.00)
        return cell
    }
    
}

//MARK: - PinterestLayoutDelegate
extension HomeVCCollectionHelper : PinterestLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        return 200
    }
    
    func collectionView(collectionView: UICollectionView, heightForCaptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        if let post = items[indexPath.item] {
            let captionFont = UIFont.systemFont(ofSize: 14)
            let captionHeight = self.height(for: post.name, with: captionFont, width: width) - 20
            let height = (captionHeight * 2) - 10
            return height
        }
        
        return 0.0
    }
    
    func height(for text: String, with font: UIFont, width: CGFloat) -> CGFloat
    {
        let nsstring = NSString(string: text)
        let maxHeight = CGFloat(70)
        let textAttributes = [NSAttributedString.Key.font : font]
        let boundingRect = nsstring.boundingRect(with: CGSize(width: width, height: maxHeight), options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil)
        return ceil(boundingRect.height)
    }
}



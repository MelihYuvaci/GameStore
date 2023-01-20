//
//  HomeCell.swift
//  GameStore
//
//  Created by Melih Yuvacı on 16.01.2023.
//

import UIKit
import Kingfisher

class HomeCell: UICollectionViewCell {

    @IBOutlet  weak var imageView: UIImageView!
    @IBOutlet private weak var nameTitle: UILabel!
    var id : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(with model: HomeCellModel){
        id = model.id
        nameTitle.text = model.name
        imageView.kf.setImage(with: URL.init(string: model.imageURL))
    }
    
}

struct HomeCellModel{
    let id : Int
    let name : String
    let imageURL : String
}


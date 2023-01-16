//
//  HomeCell.swift
//  GameStore
//
//  Created by Melih Yuvacı on 16.01.2023.
//

import UIKit
import Kingfisher

class HomeCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    func configure(with model: HomeCellModel){
        imageView.kf.setImage(with: URL.init(string: model.imageURL))
        nameTitle.text = model.name
    }

}

struct HomeCellModel{
    let imageURL : String
    let name : String
}


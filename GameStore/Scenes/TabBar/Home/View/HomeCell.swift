//
//  HomeCell.swift
//  GameStore
//
//  Created by Melih Yuvacı on 16.01.2023.
//

import UIKit

class HomeCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    func configure(with model: HomeCellModel){
        nameTitle.text = model.name
    }

}

struct HomeCellModel{
    let imageURL : String
    let name : String
}


//
//  SearchCell.swift
//  GameStore
//
//  Created by Melih Yuvacı on 19.01.2023.
//

import UIKit
import Kingfisher

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    var id: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with model: SearchCellModel){
        DispatchQueue.main.async {
            self.id = model.id
            self.gameTitle.text = model.name
            self.imageView?.kf.setImage(with: URL.init(string: model.imageURL))
        }
    }
}

struct SearchCellModel{
    let id : Int
    let name : String
    let imageURL : String
}

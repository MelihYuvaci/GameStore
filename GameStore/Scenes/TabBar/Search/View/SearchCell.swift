//
//  SearchCell.swift
//  GameStore
//
//  Created by Melih Yuvacı on 19.01.2023.
//

import UIKit

class SearchCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: SearchCellModel){
        
    }
}

struct SearchCellModel{
    let id : Int
    let name : String
    let imageURL : String
}

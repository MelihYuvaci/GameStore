//
//  FavoriteCell.swift
//  GameStore
//
//  Created by Melih Yuvacı on 20.01.2023.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var favorites : Favorites?{
        didSet {
            if let favorite = favorites{
                titleLabel.text = favorite.name!
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

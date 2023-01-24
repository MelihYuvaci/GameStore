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
    /// Configure
    func configure(with model: SearchCellModel){
        DispatchQueue.main.async {
            self.id = model.id
            self.gameTitle.text = model.name
            self.imageView?.kf.setImage(with: URL.init(string: model.imageURL))
        }
    }
}
//MARK: - Cell Model

struct SearchCellModel{
    let id : Int
    let name : String
    let imageURL : String
}

//MARK: - Accessory View
 extension SearchCell{
     
     override func layoutSubviews() {
         super.layoutSubviews()
         
         guard let imageView = self.gameImage else {return}
         let desiredWidth:CGFloat = 70;
         let currentImageWidth = imageView.frame.size.width;
         let contentWidth = self.contentView.bounds.width
         
         if (currentImageWidth != desiredWidth) {
             let widthDifference = currentImageWidth - desiredWidth;
             self.imageView?.frame = CGRect(x: imageView.frame.origin.x,
                                            y: imageView.frame.origin.y,
                                            width: desiredWidth,
                                            height: imageView.frame.size.height);
             
             if let textLabel = self.gameTitle{
                 let newX = textLabel.frame.origin.x - widthDifference
                 self.textLabel?.frame = CGRect(x: newX,
                                                y: textLabel.frame.origin.y,
                                                width: contentWidth - newX,
                                                height: textLabel.frame.size.height);
             }
             self.imageView?.contentMode = .scaleAspectFill;
         }
     }
     
}

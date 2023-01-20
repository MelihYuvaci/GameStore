//
//  NotesCell.swift
//  GameStore
//
//  Created by Melih Yuvacı on 20.01.2023.
//

import UIKit

class NotesCell: UITableViewCell {

    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameCommentLabel: UILabel!
    
    var notes: Notes?{
        didSet{
            if let note = notes {
                gameNameLabel.text = note.name!
                gameCommentLabel.text = note.comment!
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

//
//  PlaylistHeaderTableViewCell.swift
//  MusicAppLayout
//
//  Created by Pedro Gomes Rubbo Pacheco on 18/06/21.
//

import UIKit

class PlaylistHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(image: UIImage) {
        albumImageView.image = image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

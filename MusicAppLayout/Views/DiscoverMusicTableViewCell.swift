//
//  DiscoverMusicTableViewCell.swift
//  MusicAppLayout
//
//  Created by Thaís Fernandes on 24/06/21.
//

import UIKit

class DiscoverMusicTableViewCell: UITableViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUp(albumImage: UIImage, songName: String, albumName: String) {
        albumImageView.image = albumImage
        songNameLabel.text = songName
        albumNameLabel.text = albumName
    }
    
}

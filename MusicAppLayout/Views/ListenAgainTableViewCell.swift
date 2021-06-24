//
//  ListenAgainTableViewCell.swift
//  MusicAppLayout
//
//  Created by Thaís Fernandes on 24/06/21.
//

import UIKit

class ListenAgainTableViewCell: UITableViewCell {

    @IBOutlet weak var albumImage1: UIImageView!
    @IBOutlet weak var nomeAlbumLabel1: UILabel!
    
    @IBOutlet weak var albumImage2: UIImageView!
    @IBOutlet weak var nomeAlbumLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUp(image1: UIImage, image2: UIImage, albumName1: String, albumName2: String) {
        print(albumName1, albumName2)
        
        albumImage1.image = image1
        albumImage2.image = image2
        nomeAlbumLabel1.text = albumName1
        nomeAlbumLabel2.text = albumName2
    }
}

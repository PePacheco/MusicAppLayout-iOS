//
//  ArtistInfoTableViewCell.swift
//  MusicAppLayout
//
//  Created by Pedro Gomes Rubbo Pacheco on 21/06/21.
//

import UIKit

class ArtistInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var aboutArtistLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp(musicCollection: MusicCollection) {
        artistNameLabel.text = "About \(musicCollection.mainPerson)"
        aboutArtistLabel.text = musicCollection.albumDescription ?? "This artist does not have any description"
    }

}

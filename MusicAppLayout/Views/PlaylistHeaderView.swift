//
//  PlaylistHeaderView.swift
//  MusicAppLayout
//
//  Created by Pedro Gomes Rubbo Pacheco on 18/06/21.
//

import UIKit

class PlaylistHeaderView: UIView {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songsCountLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    
    func setup(image: UIImage, albumTitle: String, artistName: String, songsCount: String, release: Date) {
        albumImageView.image = image
        albumTitleLabel.text = albumTitle
        artistNameLabel.text = artistName
        songsCountLabel.text = songsCount
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        releaseLabel.text = "Released in \(dateFormatter.string(from: release))"
    }
    
}

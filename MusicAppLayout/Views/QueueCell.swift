//
//  QueueCell.swift
//  MusicAppLayout
//
//  Created by Thaís Fernandes on 23/06/21.
//

import UIKit

class QueueCell: UITableViewCell {
    var music: Music?
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
        
        guard let musicService = MusicService.shared, let music = music else {
            return
        }
        
        var isFavorite = musicService.favoriteMusics.contains(music)
        musicService.toggleFavorite(music: music, isFavorite: !isFavorite)
        isFavorite.toggle()
        favoriteButton.setImage(isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = isFavorite ? .systemRed : . systemGray
    }
    
    func setUp(image: UIImage, artist: String, musicName: String, isFavorite: Bool) {
        albumImage.image = image
        songTitle.text = musicName
        artistName.text = artist
        favoriteButton.setImage(isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = isFavorite ? .systemRed : . systemGray
    }
}

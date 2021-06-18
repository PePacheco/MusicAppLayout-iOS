//
//  AlbumPlaylistTableViewCell.swift
//  MusicAppLayout
//
//  Created by Pedro Gomes Rubbo Pacheco on 18/06/21.
//

import UIKit

class AlbumPlaylistTableViewCell: UITableViewCell {

    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    var music: Music?
    var musicService: MusicService?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addImageGesture()
    }
    
    func addImageGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        heartButton.addGestureRecognizer(tap)
    }
    
    @objc func didTapImage() {
        guard let musicService = musicService, let music = music else {
            return
        }
        var isFavorite = musicService.favoriteMusics.contains(music)
        musicService.toggleFavorite(music: music, isFavorite: isFavorite)
        isFavorite = !isFavorite
        heartButton.setImage(isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        heartButton.tintColor = isFavorite ? .systemRed : . systemGray
    }
    
    func setup(image: UIImage, artistName: String, musicName: String, isFavorite: Bool) {
        musicImageView.image = image
        musicNameLabel.text = musicName
        artistNameLabel.text = artistName
        heartButton.setImage(isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        heartButton.tintColor = isFavorite ? .systemRed : . systemGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

//
//  FavoritesTableViewCell.swift
//  MusicAppLayout
//
//  Created by Pedro Gomes Rubbo Pacheco on 21/06/21.
//

import UIKit

protocol FavoritesTableViewCellDelegate: AnyObject {
    func favoritesTableCellTapLike()
}

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    weak var delegate: FavoritesTableViewCellDelegate?
    var music: Music?
    var musicService: MusicService?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func didTapLike(_ sender: Any) {
        guard let musicService = musicService, let music = music else {
            return
        }
        var isFavorite = musicService.favoriteMusics.contains(music)
        musicService.toggleFavorite(music: music, isFavorite: !isFavorite)
        isFavorite.toggle()
        heartButton.setImage(isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        heartButton.tintColor = isFavorite ? .systemRed : . systemGray
        delegate?.favoritesTableCellTapLike()
    }
    
    func setUp(image: UIImage, artistName: String, musicName: String, isFavorite: Bool) {
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

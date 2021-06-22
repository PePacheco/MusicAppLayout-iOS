//
//  AlbumInfoTableViewCell.swift
//  MusicAppLayout
//
//  Created by Pedro Gomes Rubbo Pacheco on 21/06/21.
//

import UIKit

class AlbumInfoTableViewCell: UITableViewCell {
    
    // MARK: - Subviews
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNamelabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    var musicCollection: MusicCollection?
    var musicService: MusicService?
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        guard let musicService = try? MusicService() else {
            self.musicService = nil
            return
        }
        self.musicService = musicService
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp(musicCollection: MusicCollection) {
        guard let musicService = self.musicService, let image = musicService.getCoverImage(forItemIded: musicCollection.id) else {
            return
        }
        albumImageView.image = image
        albumNameLabel.text = musicCollection.title
        artistNamelabel.text = "Album by \(musicCollection.mainPerson)"
        countLabel.text = "\(musicCollection.musics.count) songs"
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        releaseDateLabel.text = "Released in \(dateFormatter.string(from: musicCollection.referenceDate))"
        aboutLabel.text = musicCollection.albumDescription ?? ""
    }
}

//
//  PlayerViewController.swift
//  MusicAppLayout
//
//  Created by Thaís Fernandes on 21/06/21.
//

import UIKit

class PlayerViewController: UIViewController {
            
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var playerButton: UIButton!
    
    var music: Music?
    var musicService: MusicService?
    let sliderThumb = UIImage(named: "thumb_icon")
    var isPlaying = true
    
    @IBAction func onTapPlayerButton(_ sender: UIButton) {
        isPlaying.toggle()
        
        playerButton.setImage(UIImage(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill"), for: .normal)
    }
    
    @IBAction func onTapFavorite(_ sender: UIButton) {
        guard let music = music, let musicService = try? MusicService() else {
            return
        }
        
        var isFavorite = musicService.favoriteMusics.contains(music)
        musicService.toggleFavorite(music: music, isFavorite: isFavorite)
        isFavorite = !isFavorite
        favoriteButton.setImage(isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = isFavorite ? .systemRed : . black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.setThumbImage(sliderThumb, for: .normal)
        slider.setThumbImage(sliderThumb, for: .highlighted)
        
        guard let music = music, let musicService = try? MusicService() else {
            return
        }
                
        musicService.startPlaying(music: music)

        musicNameLabel.text = music.title
        artistNameLabel.text = music.artist
        
        guard let image = musicService.getCoverImage(forItemIded: music.id) else {
            return
        }
        
        albumImageView.image = image
        
        totalTimeLabel.text = music.length.stringFromTimeInterval()
    }
}

extension TimeInterval{

    func stringFromTimeInterval() -> String {

        let time = NSInteger(self)

        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        if hours > 0 {
            return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
        } else {
            return String(format: "%0.2d:%0.2d",minutes,seconds)
        }
    }
}

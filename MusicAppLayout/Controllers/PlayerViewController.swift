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
    var music: Music?
    var musicService: MusicService?
    let sliderThumb = UIImage(named: "thumb_icon")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.setThumbImage(sliderThumb, for: .normal)
        slider.setThumbImage(sliderThumb, for: .highlighted)
        guard let music = music, let musicService = try? MusicService() else {
            return
        }
        musicNameLabel.text = music.title
        artistNameLabel.text = music.artist
        guard let image = musicService.getCoverImage(forItemIded: music.id) else {
            return
        }
        albumImageView.image = image
    }
}

//
//  PlayerViewController.swift
//  MusicAppLayout
//
//  Created by Thaís Fernandes on 21/06/21.
//

import UIKit

class PlayerViewController: UIViewController {
            
    @IBOutlet weak var slider: UISlider!
    
    let sliderThumb = UIImage(named: "thumb_icon")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.setThumbImage(sliderThumb, for: .normal)
        slider.setThumbImage(sliderThumb, for: .highlighted)
    }
}

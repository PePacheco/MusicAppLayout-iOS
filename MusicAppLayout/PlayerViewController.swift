//
//  PlayerViewController.swift
//  MusicAppLayout
//
//  Created by Thaís Fernandes on 21/06/21.
//

import UIKit

class PlayerViewController: UIViewController {
            
    @IBOutlet weak var slider: UISlider!
    
    let sliderThumb = UIImage(systemName: "circle.fill")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.setThumbImage(UIImage(named: "thumb_icon"), for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

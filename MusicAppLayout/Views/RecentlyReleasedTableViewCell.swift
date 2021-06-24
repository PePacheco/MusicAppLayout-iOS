//
//  RecentlyReleasedTableViewCell.swift
//  MusicAppLayout
//
//  Created by Pedro Gomes Rubbo Pacheco on 24/06/21.
//

import UIKit

class RecentlyReleasedTableViewCell: UITableViewCell {

    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp(image: UIImage, name: String) {
        artistImageView.image = image
        artistNameLabel.text = name
        artistImageView.layer.cornerRadius = artistImageView.bounds.width/2
    }

}

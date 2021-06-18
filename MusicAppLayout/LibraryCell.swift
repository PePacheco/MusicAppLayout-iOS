//
//  LibraryCell.swift
//  MusicAppLayout
//
//  Created by Thaís Fernandes on 18/06/21.
//

import Foundation
import UIKit

public class LibraryCell: UITableViewCell {
        
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    func setUp(title: String, subtitle: String, type: String, image: UIImage?) {
        self.title.text = title
        self.subtitle.text = "\(type) • \(subtitle)"
        
        if let image = image {
            self.itemImage.image = image
        }
    }
    
    
}

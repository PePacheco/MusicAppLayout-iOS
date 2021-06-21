//
//  LibraryCell.swift
//  MusicAppLayout
//
//  Created by Thaís Fernandes on 18/06/21.
//

import Foundation
import UIKit

protocol LibraryCellDelegate: AnyObject {
    func libraryCellDidTapNext(_ musicCollection: MusicCollection)
}

public class LibraryCell: UITableViewCell {
        
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    weak var delegate: LibraryCellDelegate?
    var musicCollection: MusicCollection?
    
    func setUp(title: String, subtitle: String, type: String, image: UIImage?, musicCollection: MusicCollection) {
        self.title.text = title
        self.subtitle.text = "\(type) • \(subtitle)"
        self.musicCollection = musicCollection
        if let image = image {
            self.itemImage.image = image
        }
    }
    
    @IBAction func didTapNext(_ sender: UIButton) {
        guard let musicCollection = self.musicCollection else {
            return
        }
        self.delegate?.libraryCellDidTapNext(musicCollection)
    }
    
}

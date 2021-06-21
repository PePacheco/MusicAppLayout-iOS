//
//  PlaylistInfoViewController.swift
//  MusicAppLayout
//
//  Created by Pedro Gomes Rubbo Pacheco on 21/06/21.
//

import UIKit

class AlbumInfoViewController: UIViewController {

    // MARK: - Subviews
    @IBOutlet weak var tableView: UITableView!
    var musicCollection: MusicCollection?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About"
        tableView.dataSource = self
    }

}

extension AlbumInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.musicCollection != nil ? 2 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let musicCollection = self.musicCollection else {
            return UITableViewCell()
        }
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "infoFirstCell") as? AlbumInfoTableViewCell else {
                return UITableViewCell()
            }
            cell.setUp(musicCollection: musicCollection)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "infoSecondCell") as? ArtistInfoTableViewCell else {
                return UITableViewCell()
            }
            cell.setUp(musicCollection: musicCollection)
            return cell
        }
    }
    
}

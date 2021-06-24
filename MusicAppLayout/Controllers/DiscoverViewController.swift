//
//  DiscoverViewController.swift
//  MusicAppLayout
//
//  Created by Pedro Gomes Rubbo Pacheco on 24/06/21.
//

import UIKit

class DiscoverViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension DiscoverViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recently-released-cell") as? RecentlyReleasedTableViewCell else {
            return UITableViewCell()
        }
        guard let musicService = MusicService.shared else {
            return UITableViewCell()
        }
        let music = musicService.loadLibrary()[indexPath.row].musics[indexPath.row]
        guard let image = musicService.getCoverImage(forItemIded: music.id) else {
            return UITableViewCell()
        }
        cell.setUp(image: image, name: music.artist)
        return cell
    }
}

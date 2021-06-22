//
//  FavoritesViewController.swift
//  MusicAppLayout
//
//  Created by Pedro Gomes Rubbo Pacheco on 21/06/21.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    var musicService: MusicService?
    var favoriteMusics: [Music]?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let musicService = try? MusicService() else {
            self.musicService = nil
            return
        }
        self.favoriteMusics = musicService.favoriteMusics
        self.musicService = musicService
        tableView.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = true
        // navigationItem.titleView = searchBar
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = favoriteMusics?.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteMusics = self.favoriteMusics, let musicService = musicService, let cell = tableView.dequeueReusableCell(withIdentifier: "favorite-music-cell") as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        guard let image = musicService.getCoverImage(forItemIded: favoriteMusics[indexPath.row].id) else {
            return UITableViewCell()
        }
        let music =  favoriteMusics[indexPath.row]
        let isFavorite = musicService.favoriteMusics.contains(music)
        cell.music = music
        cell.musicService = musicService
        cell.setUp(image: image, artistName: music.artist, musicName: music.title, isFavorite: isFavorite)
        return cell
    }
}

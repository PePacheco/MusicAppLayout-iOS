//
//  AlbumPlaylistViewController.swift
//  MusicAppLayout
//
//  Created by Pedro Gomes Rubbo Pacheco on 18/06/21.
//

import UIKit

class AlbumPlaylistViewController: UIViewController {
    
    // MARK: - Subviews
    var album: MusicCollection?
    var musicService: MusicService?
    @IBOutlet weak var albumPlaylistTableView: UITableView!
    @IBOutlet weak var headerView: PlaylistHeaderView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        albumPlaylistTableView.delegate = self
        albumPlaylistTableView.dataSource = self
        let barButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(didTapInfo))
        barButton.tintColor = .systemGreen
        navigationItem.rightBarButtonItem = barButton
        guard let musicService = try? MusicService(), let album = album else {
            self.musicService = nil
            self.album = nil
            return
        }
        self.musicService = musicService
        if let image = musicService.getCoverImage(forItemIded: album.id) {
            headerView.setup(image: image, albumTitle: album.title, artistName: "Album by " + album.mainPerson, songsCount: "\(album.musics.count) songs", release: "\(album.referenceDate)")
        }
        title = album.title
        self.album = album
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVC = segue.destination as? UINavigationController, let vc = navVC.topViewController as? AlbumInfoViewController, segue.identifier == "navigatePlaylistDetails", let musicCollection = self.album {
            vc.musicCollection = musicCollection
        }
    }
    
    // MARK: - Actions
    @objc func didTapInfo() {
        performSegue(withIdentifier: "navigatePlaylistDetails", sender: nil)
    }

}

extension AlbumPlaylistViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.album?.musics.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let album = self.album, let musicService = musicService, let cell = tableView.dequeueReusableCell(withIdentifier: "music-cell") as? AlbumPlaylistTableViewCell else {
            return UITableViewCell()
        }
        guard let image = musicService.getCoverImage(forItemIded: album.id) else {
            return UITableViewCell()
        }
        let music = album.musics[indexPath.row]
        let isFavorite = musicService.favoriteMusics.contains(music)
        cell.music = music
        cell.musicService = musicService
        cell.setUp(image: image, artistName: music.artist, musicName: music.title, isFavorite: isFavorite)
        return cell
    }
    
}

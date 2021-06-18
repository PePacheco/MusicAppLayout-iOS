//
//  AlbumPlaylistViewController.swift
//  MusicAppLayout
//
//  Created by Pedro Gomes Rubbo Pacheco on 18/06/21.
//

import UIKit

class AlbumPlaylistViewController: UIViewController {
    
    var album: MusicCollection?
    var musicService: MusicService?
    @IBOutlet weak var albumPlaylistTableView: UITableView!
    @IBOutlet weak var headerView: PlaylistHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumPlaylistTableView.delegate = self
        albumPlaylistTableView.dataSource = self
        guard let musicService = try? MusicService() else {
            self.musicService = nil
            self.album = nil
            return
        }
        let album = musicService.loadLibrary()[1]
        self.musicService = musicService
        if let image = musicService.getCoverImage(forItemIded: album.id) {
            headerView.setup(image: image, albumTitle: album.title, artistName: "Album by " + album.mainPerson, songsCount: "\(album.musics.count) songs", release: "\(album.referenceDate)")
        }
        title = album.title
        self.album = album
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
        cell.setup(image: image, artistName: music.artist, musicName: music.title, isFavorite: isFavorite)
        return cell
    }
    
}

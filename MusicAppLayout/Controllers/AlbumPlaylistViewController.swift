//
//  AlbumPlaylistViewController.swift
//  MusicAppLayout
//
//  Created by Pedro Gomes Rubbo Pacheco on 18/06/21.
//

import UIKit

class AlbumPlaylistViewController: UIViewController, PlayerViewControllerLike {
    
    // MARK: - Subviews
    @IBOutlet weak var albumPlaylistTableView: UITableView!
    @IBOutlet weak var headerView: PlaylistHeaderView!
    @IBOutlet weak var tableView: UITableView!
    
    var album: MusicCollection?
    var musicService: MusicService?
    var favoriteMusics: [Music] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        albumPlaylistTableView.delegate = self
        albumPlaylistTableView.dataSource = self
        let barButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(didTapInfo))
        barButton.tintColor = .systemGreen
        navigationItem.rightBarButtonItem = barButton
        guard let musicService = MusicService.shared, let album = album else {
            self.musicService = nil
            self.album = nil
            return
        }
        self.musicService = musicService
        if let image = musicService.getCoverImage(forItemIded: album.id) {
            let type = album.type == .playlist ? "Playlist" : "Album"
            headerView.setup(image: image, albumTitle: album.title, artistName: "\(type) by " + album.mainPerson, songsCount: "\(album.musics.count) songs", release: album.referenceDate)
        }
        title = album.title
        self.album = album
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let musicService = self.musicService else {
            return
        }
        self.favoriteMusics = musicService.favoriteMusics.filter { $0.artist == album?.mainPerson }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVC = segue.destination as? UINavigationController, let vc = navVC.topViewController as? AlbumInfoViewController, segue.identifier == "navigatePlaylistDetails", let musicCollection = self.album {
            vc.musicCollection = musicCollection
        } else if let navVC = segue.destination as? UINavigationController, let vc = navVC.topViewController as? PlayerViewController, segue.identifier == "navigatePlayer", let musicCollection = self.album {
            vc.music = musicCollection.musics[sender as! Int]
            vc.delegate = self
        }
    }
    
    func didTapLike() {
        guard let musicService = self.musicService else {
            return
        }
        self.favoriteMusics = musicService.favoriteMusics.filter { $0.artist == album?.mainPerson }
        tableView.reloadData()
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
        if count == 0 {
            let view = UIView(frame: self.tableView.bounds)
            let imageView = UIImageView(frame: CGRect(x: (self.tableView.bounds.size.width/2) - 35, y: (self.tableView.bounds.size.height/2)-50, width: 70, height: 70))
            imageView.image = UIImage(systemName: "music.note.list")
            imageView.tintColor = UIColor.systemRed
            view.addSubview(imageView)
            let messageLabel = UILabel(frame: CGRect(x: (self.tableView.bounds.size.width/2)-60, y: imageView.frame.maxY+10, width: 150, height: 35))
            messageLabel.text = "No musics"
            messageLabel.textColor = UIColor.label
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = NSTextAlignment.center
            messageLabel.font = UIFont(name: "TrebuchetMS", size: 24)
            messageLabel.sizeToFit()
            view.addSubview(messageLabel)
            let messageLabel2 = UILabel(frame: CGRect(x: (self.tableView.bounds.size.width/2)-150, y: messageLabel.frame.maxY+10, width: 300, height: 35))
            messageLabel2.text = "You can add a music to this playlist from an album, another playlist or while the music is playing."
            messageLabel2.textColor = UIColor.systemGray
            messageLabel2.numberOfLines = 0
            messageLabel2.textAlignment = NSTextAlignment.center
            messageLabel2.font = UIFont(name: "TrebuchetMS", size: 15)
            messageLabel2.sizeToFit()
            view.addSubview(messageLabel2)
            self.tableView.backgroundView = view
            self.tableView.separatorStyle = .none
        } else {
            self.tableView.restore()
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
        let isFavorite = self.favoriteMusics.contains(music)
        cell.music = music
        cell.musicService = musicService
        cell.setUp(image: image, artistName: music.artist, musicName: music.title, isFavorite: isFavorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "navigatePlayer", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let album = album, let musicService = musicService else {
            return
        }
        if album.supportsEdition {
            if editingStyle == .delete {
                let music = album.musics[indexPath.row]
                musicService.removeMusic(music, from: album)
                self.album = musicService.getCollection(id: album.id)!
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        } else {
            let alert = UIAlertController(title: "Oops", message: "You can't delete an album music", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in}))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

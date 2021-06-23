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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var musicService: MusicService?
    var favoriteMusics: [Music]?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let musicService = MusicService.shared else {
            self.musicService = nil
            return
        }
        self.musicService = musicService
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let musicService = self.musicService {
            self.favoriteMusics = musicService.favoriteMusics
            tableView.reloadData()
        }
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = favoriteMusics?.count else {
            return 0
        }
        if count == 0 {
            let view = UIView(frame: self.tableView.bounds)
            let imageView = UIImageView(frame: CGRect(x: (self.tableView.bounds.size.width/2) - 35, y: (self.tableView.bounds.size.height/2)-50, width: 70, height: 70))
            imageView.image = UIImage(systemName: "heart.slash")
            imageView.tintColor = UIColor.systemRed
            view.addSubview(imageView)
            let messageLabel = UILabel(frame: CGRect(x: (self.tableView.bounds.size.width/2)-65, y: imageView.frame.maxY+10, width: 150, height: 35))
            messageLabel.text = "No favorites"
            messageLabel.textColor = UIColor.label
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = NSTextAlignment.center
            messageLabel.font = UIFont(name: "TrebuchetMS", size: 24)
            messageLabel.sizeToFit()
            view.addSubview(messageLabel)
            let messageLabel2 = UILabel(frame: CGRect(x: (self.tableView.bounds.size.width/2)-140, y: messageLabel.frame.maxY+10, width: 300, height: 35))
            messageLabel2.text = "Save the musics you like and come back here to access them."
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
        cell.delegate = self
        return cell
    }
    
}

extension FavoritesViewController: FavoritesTableViewCellDelegate {
    func favoritesTableCellTapLike() {
        guard let musicService = self.musicService else {
            return
        }
        self.favoriteMusics = musicService.favoriteMusics
        tableView.reloadData()
    }
}

extension FavoritesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let favoritesMusic = self.favoriteMusics, let musicService = self.musicService else {
            return
        }
        if !searchText.isEmpty {
            self.favoriteMusics = favoritesMusic.filter{ music in
                return music.title.lowercased().contains(searchText.lowercased()) ||  music.artist.lowercased().contains(searchText.lowercased())
            }
            tableView.reloadData()
        } else {
            self.favoriteMusics = musicService.favoriteMusics
            tableView.reloadData()
        }
    }
}
